#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# setup full output of commands and logs to screen
# set -x

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Setup local registry and build images
$SCRIPT_DIR/build-push-local.sh

# Check if kubectl is accessible
if ! command -v kubectl &> /dev/null; then
  echo "Please ensure kubectl is installed and configured"
  exit 1
fi

# Check if local Kubernetes is running
if ! kubectl cluster-info &> /dev/null; then
  echo "Unable to connect to Kubernetes. Please make sure it is running."
  exit 1
fi

echo "Kubernetes cluster is up and running"

# Check if local registry is accessible
if ! curl -s http://localhost:5000/v2/_catalog > /dev/null; then
  echo "Local registry at localhost:5000 doesn't seem to be accessible."
  echo "Please ensure a local registry is running at localhost:5000"
  echo "You can start one with: docker run -d -p 5000:5000 --restart=always --name registry registry:2"
  read -p "Continue anyway? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

# Deploy the application
$SCRIPT_DIR/install-helm-local.sh

# Wait for the application to be ready
echo "Waiting for the application to be ready..."
MAX_RETRIES=30
RETRY_COUNTER=0
SUCCESS=false

while [ $RETRY_COUNTER -lt $MAX_RETRIES ]; do
  # Check all pods are either Running or Completed
  if kubectl get pods | grep -v "Running\|Completed" | grep -q "app2bshops"; then
    echo "Waiting for all pods to be ready... ($((RETRY_COUNTER + 1))/$MAX_RETRIES)"
    sleep 5
    ((RETRY_COUNTER++))
  else
    # Verify all pod readiness
    TOTAL_PODS=$(kubectl get pods -l app.kubernetes.io/instance=app2bshops -o name | wc -l | tr -d ' ')
    READY_PODS=$(kubectl get pods -l app.kubernetes.io/instance=app2bshops -o jsonpath='{range .items[*]}{.status.containerStatuses[0].ready}{"\n"}{end}' | grep -c "true")
    
    if [ "$TOTAL_PODS" -eq "$READY_PODS" ] && [ "$TOTAL_PODS" -gt 0 ]; then
      echo "All $TOTAL_PODS pods are ready!"
      SUCCESS=true
      break
    else
      echo "Waiting for pod readiness: $READY_PODS/$TOTAL_PODS ready... ($((RETRY_COUNTER + 1))/$MAX_RETRIES)"
      sleep 5
      ((RETRY_COUNTER++))
    fi
  fi
done

if [ "$SUCCESS" = false ]; then
  echo "Timed out waiting for application to be ready. Check pod status:"
  kubectl get pods
  echo "Continuing anyway, but the application might not be fully functional."
else
  echo "Application is ready"
fi

# Check if the frontend and backend services are available
if ! kubectl get svc | grep -q "app2bshops-frontend"; then
  echo "Frontend service is not available"
  exit 1
fi
if ! kubectl get svc | grep -q "app2bshops-backend"; then
  echo "Backend service is not available"
  exit 1
fi
echo "Frontend and backend services are available"
# Check if the frontend and backend pods are running
if ! kubectl get pods | grep -q "app2bshops-frontend"; then
  echo "Frontend pod is not running"
  exit 1
fi
if ! kubectl get pods | grep -q "app2bshops-backend"; then
  echo "Backend pod is not running"
  exit 1
fi
echo "Frontend and backend pods are running"

echo "Port-forwarding local services for easy access"
$SCRIPT_DIR/port-forward-local.sh
