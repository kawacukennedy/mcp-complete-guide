#!/bin/bash
set -e

# Run load tests against production

# Install k6 if not present
if ! command -v k6 &> /dev/null; then
    echo "Installing k6..."
    # For macOS
    brew install k6
fi

# Run tests
k6 run --vus 10 --duration 30s loadtests/k6/script.js

echo "Load test completed"