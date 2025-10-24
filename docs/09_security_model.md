# 09 — Security Model

## Authentication

- OAuth2: client credentials for service-to-service
- OIDC: JWT tokens with claims
- mTLS: certificate-based auth

## Authorization

- RBAC: roles with scopes (e.g., file:read)
- ABAC: policies based on context
- OPA Rego for policy as code

## Input Validation

- JSON Schema for structure
- Semantic checks (e.g., no SQL injection)
- Rate limiting per tool

## Encryption

- TLS 1.3 for transport
- Encrypt sensitive data at rest

## Auditing

- Log all invokes with provenance
- WORM storage for audit logs