# 05 — Message Formats: JSON-RPC & Protobuf

## JSON-RPC 2.0

MCP uses JSON-RPC 2.0 for HTTP/WS transports. Requests and responses follow the standard:

- Request: `{"jsonrpc":"2.0","id":"uuid","method":"invoke","params":{"tool":"name","input":{...},"meta":{...}}}`
- Response: `{"jsonrpc":"2.0","id":"uuid","result":{...}}` or `{"jsonrpc":"2.0","id":"uuid","error":{"code":int,"message":"str"}}`

## Protobuf

For gRPC, use `spec/mcp.proto`. Compile with `protoc --go_out=. --go-grpc_out=. mcp.proto`.

Example unary invoke:

```protobuf
message InvokeRequest {
  string id = 1;
  string tool = 2;
  bytes input_json = 3;
  Metadata meta = 4;
}
```

## Conversion

- JSON-RPC params.input → Protobuf input_json (JSON bytes)
- Protobuf output_json → JSON-RPC result