package mcp.authz

# Example: allow if requester has required scopes
allow {
  input.capability
  required := data.capabilities[input.capability].scopes
  req_scopes := input.auth.scopes
  required_subset(required, req_scopes)
}

required_subset(req, have) {
  count({s | s := req[_]}) == count({s | s := req[_]; s == have[_]})
}
