# Production Runbook for MCP Deployment

## Incident Response

### High Error Rate
1. Check logs: `kubectl logs -f deployment/mcp-python-server`
2. Scale up: `kubectl scale deployment mcp-python-server --replicas=5`
3. Check metrics in Grafana
4. Rollback if needed: `kubectl rollout undo deployment/mcp-python-server`

### Service Down
1. Check pod status: `kubectl get pods`
2. Describe pod: `kubectl describe pod <pod-name>`
3. Restart deployment: `kubectl rollout restart deployment/mcp-python-server`

## Maintenance

### Updates
1. Build new images with tags
2. Update Helm values
3. `helm upgrade mcp .`
4. Monitor rollout

### Scaling
- Horizontal: `kubectl autoscale deployment mcp-python-server --cpu-percent=70 --min=2 --max=10`
- Vertical: Update resource requests/limits in manifests

## Monitoring

- Alerts: Set up PagerDuty for critical metrics
- Dashboards: Import dashboards/grafana/mcp-dashboard.json
- Logs: Use ELK or cloud logging

## Security

- Rotate secrets quarterly
- Review OPA policies monthly
- Audit access logs weekly

## Handoff Checklist

- [ ] Infrastructure docs updated
- [ ] Access credentials shared securely
- [ ] Monitoring alerts configured
- [ ] Backup procedures documented
- [ ] Emergency contacts listed