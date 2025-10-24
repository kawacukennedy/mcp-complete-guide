output "vpc_id" {
  value = aws_vpc.mcp_vpc.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.mcp_cluster.name
}

output "ecr_python_url" {
  value = aws_ecr_repository.mcp_python.repository_url
}

output "ecr_node_url" {
  value = aws_ecr_repository.mcp_node.repository_url
}

output "ecr_go_url" {
  value = aws_ecr_repository.mcp_go.repository_url
}