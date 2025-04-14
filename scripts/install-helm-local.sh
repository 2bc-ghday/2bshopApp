#!/bin/bash
# Script to install the app2bshops chart with local development values
# This ensures the correct configuration is always used for local development

set -e  # Exit immediately if a command exits with a non-zero status

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="$SCRIPT_DIR/.."
CHART_DIR="$APP_DIR/charts/app2bshops"
VALUES_FILE="$CHART_DIR/values-local-dev.yaml"

# Check if values file exists
if [ ! -f "$VALUES_FILE" ]; then
  echo "Error: Local development values file not found at $VALUES_FILE"
  exit 1
fi

# Check if the app2bshops release already exists
if helm list -q | grep -q "app2bshops"; then
  echo "Found existing app2bshops deployment. Uninstalling..."
  helm uninstall app2bshops
fi

# Update dependencies
echo "Updating Helm chart dependencies..."
helm dependency update "$CHART_DIR"

# Install with local-dev values
echo "Installing app2bshops with local development values..."
helm install app2bshops "$CHART_DIR" -f "$VALUES_FILE"

echo ""
echo "Installation complete! The application may take a few moments to start."
echo "Run 'kubectl get pods' to check the status of the pods."
