#!/bin/bash
set -e

echo "Starting MCP Complete Guide Deployment"

# 1. Build Docker Images
echo "Building Docker images..."

# Python Server
cd examples/python_server
docker build -t mcp-python:latest .
cd ../..

# Node Server
cd examples/node_server
docker build -t mcp-node:latest .
cd ../..

# Go Server
cd examples/go_server
docker build -t mcp-go:latest .
cd ../..

echo "Docker images built successfully"

# 2. Run Servers Locally
echo "Starting servers..."

# Python on 8080
docker run -d --name mcp-python -p 8080:8080 mcp-python:latest

# Node on 8081
docker run -d --name mcp-node -p 8081:8081 mcp-node:latest

# Go on 50051/8080
docker run -d --name mcp-go -p 50051:50051 -p 8082:8080 mcp-go:latest

echo "Servers started:"
echo "Python: http://localhost:8080"
echo "Node: http://localhost:8081"
echo "Go: localhost:50051 (gRPC), http://localhost:8082 (HTTP)"

# 3. Test Deployments
echo "Testing deployments..."
sleep 5

curl -s http://localhost:8080/healthz && echo "Python health OK" || echo "Python health FAIL"
curl -s http://localhost:8081/manifest && echo "Node manifest OK" || echo "Node manifest FAIL"
# Go health check if implemented

echo "Deployment complete. Use 'docker stop mcp-python mcp-node mcp-go' to stop."