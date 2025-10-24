# MCP Go SDK

gRPC client for MCP servers.

## Usage

Generate protobuf code:

```bash
protoc --go_out=. --go-grpc_out=. ../../spec/mcp.proto
```

Then run:

```bash
go run client.go
```