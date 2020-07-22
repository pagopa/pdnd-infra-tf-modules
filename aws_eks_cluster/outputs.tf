output "id" {
  value = aws_eks_cluster.this.id
}

output "arn" {
  value = aws_eks_cluster.this.arn
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "platform_version" {
  value = aws_eks_cluster.this.platform_version
}

output "version" {
  value = aws_eks_cluster.this.version
}
