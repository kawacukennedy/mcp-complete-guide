# 07 — Transport Patterns

## HTTP/JSON-RPC

- POST `/invoke` with JSON-RPC body
- Streaming via chunked transfer or WS upgrade

## WebSocket

- Bidirectional: client sends invoke, server streams results
- Example: `ws://server/ws` with JSON-RPC over WS frames

## gRPC

- Unary: `ToolService.Invoke`
- Streaming: `ToolService.StreamInvoke` for real-time

## Kafka/RabbitMQ

- Publish invoke requests to queue, consume responses
- Use correlation_id for matching

## STDIN/STDOUT Plugin

- MCP as subprocess: stdin JSON-RPC, stdout responses
- For local tool execution