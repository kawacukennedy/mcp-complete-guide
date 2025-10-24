#!/bin/bash
# Vault Setup Example

# Start Vault dev server
vault server -dev -dev-root-token-id="root"

# Enable KV secrets
vault secrets enable -path=secret kv-v2

# Add sample secrets
vault kv put secret/mcp/api_key value="sample-key"

echo "Vault running on http://localhost:8200 with token 'root'"