# 13 — Error Handling & Retry Model

## Canonical Errors

- 400: Invalid request
- 401: Unauthorized
- 403: Forbidden
- 404: Tool not found
- 500: Internal error

## Retry Semantics

- Idempotent tools: safe to retry
- Exponential backoff
- Circuit breaker for failures

## Client Handling

```python
if response.status == 429:
    sleep(2 ** attempt)
    retry()
```

## Logging Errors

- Structured logs with error codes
- Alert on high error rates