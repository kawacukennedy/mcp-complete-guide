# Runbooks (detailed)

## Runbook: High error-rate for a capability
1. Identify scope: which tool(s) and pods.
2. Check recent deploys and rollouts.
3. Check logs for common error patterns.
4. If new release suspected, rollback to previous image.
5. Create temporary circuit-breakers or rate-limits.
6. Follow postmortem template.

## Runbook: Suspected data exfiltration
1. Isolate service: block network egress.
2. Preserve logs & evidence (WORM) and increase retention.
3. Rotate all credentials used by the service.
4. Engage security/compliance, notify legal as required.

## Runbook: Token compromise / failing auth
1. Revoke current tokens and rotate keys.
2. Implement emergency key rotation.
3. Update clients/SDKs with new issuer metadata.
