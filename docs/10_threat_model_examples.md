# 10 — Threat Model Examples

## STRIDE Analysis

- Spoofing: Impersonate client → mTLS mitigation
- Tampering: Modify requests → TLS integrity
- Repudiation: Deny actions → Audit logs
- Information Disclosure: Leak data → Encryption, redaction
- Denial of Service: Flood invokes → Rate limits
- Elevation of Privilege: Access unauthorized tools → ABAC

## Example Threats

- Malicious input causing code execution
- Token leakage leading to data exfil
- Insider threats via compromised creds

## Mitigations

- Sandboxing for code tools
- Network egress controls
- Regular security scans