const axios = require('axios');

class MCPClient {
  constructor(baseURL) {
    this.baseURL = baseURL;
  }

  async getManifest() {
    const response = await axios.get(`${this.baseURL}/manifest`);
    return response.data;
  }

  async invoke(tool, input, meta = {}) {
    const body = {
      jsonrpc: '2.0',
      id: Math.random().toString(36).substr(2, 9),
      params: { tool, input, meta }
    };
    const response = await axios.post(`${this.baseURL}/invoke`, body);
    return response.data;
  }
}

module.exports = MCPClient;

// Example usage
if (require.main === module) {
  const client = new MCPClient('http://localhost:8080');
  client.invoke('get_time', {}).then(console.log);
}