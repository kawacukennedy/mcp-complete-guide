#!/bin/bash
set -e

# Push production images to ECR

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=us-east-1

# Login to ECR
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

# Build and push Python
cd examples/python_server
docker build -t mcp-python:latest .
docker tag mcp-python:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/mcp-python:v1.0.0
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/mcp-python:v1.0.0

# Build and push Node
cd ../node_server
docker build -t mcp-node:latest .
docker tag mcp-node:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/mcp-node:v1.0.0
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/mcp-node:v1.0.0

# Build and push Go
cd ../go_server
docker build -t mcp-go:latest .
docker tag mcp-go:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/mcp-go:v1.0.0
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/mcp-go:v1.0.0

echo "Images pushed to ECR"