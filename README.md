# MCP Complete Guide

**The most exhaustive repository spec for Model Context Protocol (MCP) and MCP servers.**

This repository contains:
- Formal spec (JSON Schema + Protobuf + OpenAPI)
- Multi-language reference servers (Python aiohttp, Node Express + WS, Go gRPC + HTTP)
- SDKs (Python, Node, Go) and CLI `mcpctl`
- Full CI/CD with security scanning and SBOM generation
- Kubernetes Helm chart and example manifests
- Observability: OpenTelemetry, Prometheus metrics, Grafana dashboard JSON
- Security: OPA policies (Rego), sample mTLS and OAuth setups, runbooks
- Tests: unit, contract, integration, fuzzing harness, load test scripts (k6 & locust)

See `SUMMARY.md` for the table of contents and `docs/` for detailed chapters.
