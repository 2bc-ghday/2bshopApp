#!/bin/bash
# Script to port-forward local services for easy access


# Port-forward services for easy access
kubectl port-forward svc/app2bshops-frontend 5173:80 > /dev/null 2>&1 &
FRONTEND_PF_PID=$!
echo "Frontend available at http://localhost:5173"

kubectl port-forward svc/app2bshops-backend 8000:8000 > /dev/null 2>&1 &
BACKEND_PF_PID=$!
echo "Backend API available at http://localhost:8000"

echo "Press Ctrl+C to stop port-forwarding and exit"

trap "kill $FRONTEND_PF_PID $BACKEND_PF_PID 2>/dev/null" EXIT

# Wait for Ctrl+C
wait