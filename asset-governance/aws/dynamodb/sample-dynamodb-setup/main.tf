resource "aws_dynamodb_table" "example" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"  # More cost-effective for predictable workloads
  read_capacity  = 1  # Minimum read capacity units
  write_capacity = 1  # Minimum write capacity units
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  # Enable point-in-time recovery (costs extra but recommended for production)
  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  # Server-side encryption at rest
  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms_key_arn
  }

  # Add tags for cost allocation and management
  tags = merge(
    {
      Name        = var.table_name
      Environment = var.environment
      ManagedBy   = "terraform"
    },
    var.additional_tags
  )
}
