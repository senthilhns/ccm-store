output "cluster_identifier" {
  description = "The identifier of the Redshift cluster."
  value       = aws_redshift_cluster.redshift_cluster.id
}

output "cluster_endpoint" {
  description = "The endpoint of the Redshift cluster."
  value       = aws_redshift_cluster.redshift_cluster.endpoint
}

output "master_password" {
  description = "The master password for the Redshift cluster."
  value       = local.master_password
  sensitive   = true
}
