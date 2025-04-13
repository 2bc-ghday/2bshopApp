#!/bin/bash

# Make the script executable
chmod +x ./setup-local-registry.sh

# Setup local registry and build images
./setup-local-registry.sh

# Check if kubectl is accessible (for Rancher Desktop)
if ! command -v kubectl &> /dev/null; then
  echo "Please ensure kubectl is installed and configured"
  exit 1
fi

# Check if Rancher Desktop/Kubernetes is running
if ! kubectl cluster-info &> /dev/null; then
  echo "Unable to connect to Kubernetes. Please make sure Rancher Desktop is running."
  exit 1
fi

echo "Kubernetes cluster is running via Rancher Desktop"

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
echo "Deploying 2bshop application..."
cd /Users/dl2bcloud/_dev_/2bc-ghday/2bshopApp
helm dependency update ./charts/2bshop
helm upgrade --install 2bshop ./charts/2bshop --wait

# Check deployment status
echo "Checking deployment status..."
kubectl get pods

# Port-forward services for easy access
kubectl port-forward svc/shop-frontend 3000:80 > /dev/null 2>&1 &
FRONTEND_PF_PID=$!
echo "Frontend available at http://localhost:3000"

kubectl port-forward svc/shop-backend 8000:8000 > /dev/null 2>&1 &
BACKEND_PF_PID=$!
echo "Backend API available at http://localhost:8000"

echo "Press Ctrl+C to stop port-forwarding and exit"
trap "kill $FRONTEND_PF_PID $BACKEND_PF_PID 2>/dev/null" EXIT

# Wait for Ctrl+C
wait
