#!/bin/bash

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Check if local registry is accessible
if ! curl -s http://localhost:5000/v2/_catalog > /dev/null; then
  echo "Local registry at localhost:5000 is not accessible."
  echo "Setting up local Docker registry at localhost:5000..."
  docker run -d -p 5000:5000 --restart=always --name registry registry:2
else
  echo "Local registry is accessible at localhost:5000"
fi

# Build frontend and backend images using docker-compose
echo "Building images using docker-compose..."
cd $APP_DIR
docker compose build frontend backend

# Tag and push images to local registry
echo "Tagging and pushing frontend image..."
docker tag frontend:latest localhost:5000/frontend:latest
docker push localhost:5000/frontend:latest

echo "Tagging and pushing backend image..."
docker tag backend:latest localhost:5000/backend:latest
docker push localhost:5000/backend:latest

echo "Images built and pushed to local registry"

# Return to the original directory
cd $SCRIPT_DIR
