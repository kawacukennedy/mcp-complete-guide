# Security Examples

## mTLS Setup

Generate CA:

```bash
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 365 -key ca.key -sha256 -out ca.crt
```

Generate server cert:

```bash
openssl genrsa -out server.key 2048
openssl req -subj "/CN=localhost" -new -key server.key -out server.csr
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -out server.crt
```

## OAuth2 Client Credentials

Use oauth2-proxy or mock:

```bash
# Mock issuer
curl -X POST https://mock-issuer/token -d "grant_type=client_credentials&client_id=...&client_secret=..."
```

## JWT Verification (Python)

```python
import jwt
import requests

def verify_jwt(token):
    # Fetch JWKS
    jwks = requests.get('https://issuer/.well-known/jwks.json').json()
    public_key = jwt.algorithms.RSAAlgorithm.from_jwk(jwks['keys'][0])
    payload = jwt.decode(token, public_key, algorithms=['RS256'])
    return payload
```