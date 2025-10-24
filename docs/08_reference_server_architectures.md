# 08 — Reference Server Architectures

## Python (aiohttp)

- Async handlers for invoke
- Prometheus metrics, structured logging
- Schema validation with jsonschema

## Node.js (Express + WS)

- JWT auth middleware
- WS for streaming
- Policy enforcement per capability

## Go (gRPC + HTTP)

- Generated gRPC server
- HTTP gateway for REST API
- OTEL tracing

## Common Patterns

- Middleware for auth, logging, metrics
- Capability dispatch table
- Error handling with canonical codes