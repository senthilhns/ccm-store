output "cluster_name" {
  description = "EKS cluster name."
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "EKS cluster API endpoint."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID for the EKS cluster."
  value       = aws_security_group.eks_cluster.id
}

output "node_group_role_arn" {
  description = "IAM role ARN for EKS node group."
  value       = aws_iam_role.eks_node_group.arn
}

output "key_pair_name" {
  value = aws_key_pair.eks.key_name
}

output "eks_private_key_pem" {
  value     = tls_private_key.eks.private_key_pem
  sensitive = true
}
