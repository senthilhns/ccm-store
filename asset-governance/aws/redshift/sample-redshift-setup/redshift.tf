# Using a simple static password for testing purposes
# In production, use a more secure approach with proper secret management
locals {
  master_password = "Test1234"  # Simple password for testing
}

resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier = "${var.stack_prefix_id}-${var.cluster_identifier}"
  node_type          = var.node_type
  master_username    = var.master_username
  master_password    = local.master_password
  database_name      = var.database_name
  publicly_accessible = var.publicly_accessible

  # Set to 15 days to demonstrate Cloud Custodian rule for excessive retention
  # This will be flagged by the Cloud Custodian rule (threshold is 14 days)
  automated_snapshot_retention_period = var.snapshot_retention_period

  cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.redshift_public.id]

  # Add tags to help identify this as a non-production environment
  # This helps the Cloud Custodian rule identify non-prod resources
  tags = merge(var.tags, {
    "Name"        = "${var.stack_prefix_id}-${var.cluster_identifier}",
    "StackPrefix" = var.stack_prefix_id,
    "Environment" = "nonprod",
    "CostCenter"  = "testing",
    "Owner"       = "cloud-custodian-demo"
  })

  # For the cross-region snapshot copy demonstration, we'll use a local-exec provisioner
  # to enable it after the cluster is created, as the native block isn't available
  provisioner "local-exec" {
    command = <<EOT
      echo 'For demonstration purposes, you would enable cross-region snapshot copy here using AWS CLI:'
      echo 'aws redshift enable-snapshot-copy \
        --cluster-identifier ${self.id} \
        --destination-region ${var.snapshot_copy_destination_region} \
        --retention-period ${var.snapshot_copy_retention_period}'
    EOT
  }

  depends_on = [aws_redshift_subnet_group.redshift_subnet_group]

}
