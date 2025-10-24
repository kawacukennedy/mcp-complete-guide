#!/bin/bash
set -e

# Backup script for production data

DATE=$(date +%Y%m%d_%H%M%S)

# Backup K8s configs
kubectl get all -o yaml > backup/k8s-configs-$DATE.yaml

# Backup secrets (careful with sensitive data)
# kubectl get secrets -o yaml > backup/secrets-$DATE.yaml

# Backup monitoring data (if using persistent volumes)
# Use velero or similar for full backups

echo "Backup completed: backup/k8s-configs-$DATE.yaml"