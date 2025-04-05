#!/bin/bash

# Find and kill all kubectl port-forward processes
PIDS=$(ps aux | grep 'kubectl port-forward' | grep -v grep | awk '{print $2}')

if [ -z "$PIDS" ]; then
  echo "No port-forward processes found."
else
  echo "Stopping the following port-forward processes:"
  echo "$PIDS"
  kill $PIDS
  echo "Port-forwarding stopped."
fi