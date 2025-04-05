#!/bin/bash

# Port-forward frontend service
nohup kubectl port-forward svc/frontend 5173:5173 &

# Port-forward backend service
nohup kubectl port-forward svc/backend 8000:8000 &

echo "Port-forwarding started for frontend (5173) and backend (8000)."