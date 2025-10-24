#!/bin/bash
set -e

echo "Deploying to Kubernetes"

# Assume kubectl configured
kubectl apply -f python-deployment.yaml
kubectl apply -f deployment.yaml  # Go
kubectl apply -f helm/  # If using Helm

echo "Waiting for deployments..."
kubectl wait --for=condition=available --timeout=300s deployment/mcp-python-server
kubectl wait --for=condition=available --timeout=300s deployment/mcp-go-server

echo "Services:"
kubectl get services

echo "K8s deployment complete"