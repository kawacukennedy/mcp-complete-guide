# 03 — Exhaustive Topic Index

This file is a checklist mapping to docs and code. For each item, the repo must include explanations, examples, tests, or automation:

1. Protocol & message formats (JSON-RPC, JSON schema, Protobuf + gRPC) — *spec + examples*
2. Capability manifest: schema, examples, versioning, discovery — *spec + example manifest*
3. JSON Schema best practices: required fields, `additionalProperties`, semantic validation — *schemas + tests*
4. Transport implementations: STDIN/STDOUT plugin, HTTP (REST + JSON-RPC), WebSocket streaming, gRPC (unary & streaming), Kafka/RabbitMQ patterns — *examples*
5. Authentication: OAuth2 client credentials, OIDC tokens, JWT verification, mTLS config examples — *examples & CI tests*
6. Authorization: capability-based RBAC, sample policy definitions (Rego), ABAC examples — *policy + tests*
7. Input validation & sanitization: whitelists, regex, schema & semantic checks — *examples*
8. Error model: canonical errors, codes list, retry semantics — *spec + client handling examples*
9. Idempotency: token usage, deduplication examples — *code + tests*
10. Auditing & provenance: sample immutable audit logs, Merkle signed logs (example), WORM storage guidance — *docs + scripts*
11. Observability: OpenTelemetry demo, Prometheus metrics exposition, Grafana JSON dashboards — *examples*
12. Security: threat models, sandboxing code-execution (WASM/container), network egress controls — *docs + runbooks*
13. CI/CD: lint, tests, SBOM generation (syft), container scans (trivy), dependency checks (snyk) — *workflows*
14. Packaging & deploy: Dockerfile, Helm chart, k8s manifests (readiness/liveness, NetworkPolicy) — *artifacts*
15. SDKs & CLI: Python, Node, Go; typed clients; `mcpctl` commands — *examples*
16. Tests: unit, integration, contract, fuzz tests (Atheris/boofuzz), load tests (k6/locust) — *scripts & CI*
17. Examples: file search, db query (Postgres), vector search example (milvus/FAISS), secret retrieval with Vault — *examples*
18. Release process & changelog automation — *docs & GH Actions*
19. Governance: contribution rules, PR process, security policy — *files*
20. Legal & compliance: PII redaction, data retention, GDPR, PCI/HIPAA considerations — *docs*

> The repo generator must ensure these items have corresponding files/folders and at least one runnable example where applicable.
