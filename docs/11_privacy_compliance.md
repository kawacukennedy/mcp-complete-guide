# 11 — Privacy & Compliance

## PII Handling

- Redact sensitive data in logs/audits
- Encrypt PII in storage
- Data minimization: collect only necessary

## Compliance

- GDPR: Data subject rights, consent
- HIPAA: PHI protection
- PCI: Card data handling

## Retention

- Auto-delete logs after 90 days
- Backup encryption
- Audit retention policies

## Example Redaction

```python
import re
def redact_pii(text):
    return re.sub(r'\b\d{3}-\d{2}-\d{4}\b', '[SSN]', text)
```