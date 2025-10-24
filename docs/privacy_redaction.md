# Privacy Redaction

## PII Redaction Code

```python
import re

def redact_pii(text):
    # SSN
    text = re.sub(r'\b\d{3}-\d{2}-\d{4}\b', '[REDACTED_SSN]', text)
    # Email
    text = re.sub(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', '[REDACTED_EMAIL]', text)
    # Phone
    text = re.sub(r'\b\d{3}-\d{3}-\d{4}\b', '[REDACTED_PHONE]', text)
    return text
```

## Retention Policies

- Logs: 90 days
- Audit trails: 7 years
- User data: Until account deletion

## Compliance

Ensure redaction before logging or storing.