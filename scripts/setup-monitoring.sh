#!/bin/bash
set -e

# Deploy monitoring stack to K8s

kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f k8s/monitoring-stack.yaml

# Wait for deployments
kubectl wait --for=condition=available --timeout=300s deployment/prometheus -n monitoring
kubectl wait --for=condition=available --timeout=300s deployment/grafana -n monitoring

# Port forward for access
kubectl port-forward -n monitoring svc/prometheus 9090:9090 &
kubectl port-forward -n monitoring svc/grafana 3000:3000 &

echo "Monitoring stack deployed. Access Grafana at http://localhost:3000 (admin/admin)"