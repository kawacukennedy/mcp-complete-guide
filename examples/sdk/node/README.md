# MCP Node.js SDK

Promise-based client for MCP servers.

## Installation

```bash
npm install
```

## Usage

```javascript
const MCPClient = require('./client');

const client = new MCPClient('http://localhost:8080');

(async () => {
  const manifest = await client.getManifest();
  console.log(manifest);

  const result = await client.invoke('echo', { message: 'hello' });
  console.log(result);
})();
```