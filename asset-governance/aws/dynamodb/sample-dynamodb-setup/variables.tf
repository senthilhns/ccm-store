variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "ap-south-1"
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "example-dynamodb-table"
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encryption at rest"
  type        = string
  default     = null  # Will use AWS managed key if not specified
}

variable "enable_point_in_time_recovery" {
  description = "Whether to enable point-in-time recovery"
  type        = bool
  default     = false  # Disabled by default to minimize costs
}

variable "additional_tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}
