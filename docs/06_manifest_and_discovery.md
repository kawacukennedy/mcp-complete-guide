# 06 — Manifest & Discovery

## Manifest Schema

See `spec/manifest.schema.json`. Includes version, capabilities with schemas, auth requirements.

## Discovery

- GET `/manifest` or `/.well-known/mcp/manifest`
- Clients load manifest to discover tools, schemas, scopes.

## Versioning

- Semantic versioning: MAJOR.MINOR.PATCH
- Clients check `mcp_version` compatibility.

## Example Manifest

```json
{
  "mcp_version": "1.0.0",
  "capabilities": [
    {"name": "get_time", "input_schema_ref": "/spec/schemas/empty.json"}
  ]
}
```