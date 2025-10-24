# Observability — metrics, tracing, logging

## Metrics (prometheus)
- Expose: `mcp_invocations_total{tool}`, `mcp_invoke_latency_ms_bucket{tool}`, `mcp_errors_total{tool,code}`
- Example scrape config snippet

## Tracing
- Propagate `trace_id` and `span_id` in `meta`
- Use OpenTelemetry and exporters (OTLP) to jaeger/tempo

## Logs
- Structured JSON logs with fields: timestamp, severity, service, tool, request_id, trace_id, user
- Example log line JSON in `examples/logs/sample_log.json`
