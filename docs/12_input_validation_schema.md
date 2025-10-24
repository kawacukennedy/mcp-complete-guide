# 12 — Input Validation & Schema

## JSON Schema Best Practices

- Use `additionalProperties: false`
- Required fields for safety
- Semantic validation (e.g., URL format)

## Validation Libraries

- Python: jsonschema
- Node: ajv
- Go: gojsonschema

## Example Schema

```json
{
  "type": "object",
  "required": ["query"],
  "properties": {
    "query": {"type": "string", "minLength": 1}
  },
  "additionalProperties": false
}
```

## Sanitization

- Escape special chars
- Whitelist allowed values
- Reject oversized inputs