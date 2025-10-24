# AWS Infrastructure for MCP Production Deployment

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "mcp_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "mcp-vpc"
  }
}

# Subnets
resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.mcp_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "mcp-public-${count.index}"
  }
}

# EKS Cluster
resource "aws_eks_cluster" "mcp_cluster" {
  name     = "mcp-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }
}

# IAM Roles
resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

# ECR Repository
resource "aws_ecr_repository" "mcp_python" {
  name = "mcp-python"
}

resource "aws_ecr_repository" "mcp_node" {
  name = "mcp-node"
}

resource "aws_ecr_repository" "mcp_go" {
  name = "mcp-go"
}

# Variables
variable "region" {
  default = "us-east-1"
}

data "aws_availability_zones" "available" {}