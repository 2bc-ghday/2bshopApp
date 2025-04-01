#!/bin/bash

# Exit on error
set -e

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if Minikube is installed
if ! command_exists minikube; then
  echo "Minikube is not installed. Please install Minikube first."
  exit 1
fi

# Start Minikube cluster
echo "Starting Minikube cluster..."
minikube start --driver=docker

# Enable Ingress Controller
echo "Enabling Ingress Controller..."
minikube addons enable ingress

# Create PersistentVolumeClaim (PVC)
echo "Creating PersistentVolumeClaim (PVC)..."
kubectl apply -f ../k8s-manifests/db-pvc.yml

# Create Secrets
echo "Creating Secrets..."
kubectl create secret generic backend-secret --from-literal=key=value --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic db-secret --from-literal=username=admin --from-literal=password=admin123 --from-literal=database=mydb --dry-run=client -o yaml | kubectl apply -f -

# Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."
kubectl apply -f ../k8s-manifests/

# Get Minikube IP and display access information
MINIKUBE_IP=$(minikube ip)
echo "Cluster is up and running. Access your services at http://$MINIKUBE_IP"
