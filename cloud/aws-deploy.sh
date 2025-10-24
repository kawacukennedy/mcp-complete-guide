#!/bin/bash
# AWS ECS Deployment Example

# Build and push images
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-1.amazonaws.com

docker tag mcp-python:latest <account>.dkr.ecr.us-east-1.amazonaws.com/mcp-python:latest
docker push <account>.dkr.ecr.us-east-1.amazonaws.com/mcp-python:latest

# Create ECS cluster, task definition, service
# Use AWS CLI or Console

echo "Images pushed to ECR. Create ECS services manually."