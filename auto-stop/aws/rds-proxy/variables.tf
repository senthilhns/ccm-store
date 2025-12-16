variable "cloud_connector_id" {
  type        = string
  description = "Cloud connector ID for Harness autostopping integration."
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources in."
  default     = "ap-south-1"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the proxy will be deployed."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the proxy."
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of AWS Security Group IDs to attach to the proxy."
  default     = []
}

variable "key_pair_name" {
  type        = string
  description = "Name of the AWS EC2 key pair for the proxy."
}

variable "schedule_name" {
  description = "Name to set for the rule/schedule indicating the schedule type."
  type        = string
}

variable "proxy_machine_type" {
  description = "Instance type for the proxy VM (e.g., t3.medium)."
  type        = string
}

variable "harness_api_key" {
  description = "Harness NG API key. Should be set from the HARNESS_PLATFORM_API_KEY environment variable."
  type        = string
  sensitive   = true
}

variable "harness_account_id" {
  description = "Harness Account ID (optional if set via HARNESS_ACCOUNT_ID env var)"
  type        = string
  default     = null
}

variable "harness_org_id" {
  description = "Harness Org ID (optional if set via HARNESS_ORG_ID env var)"
  type        = string
  default     = null
}

variable "harness_project_id" {
  description = "Harness Project ID (optional if set via HARNESS_PROJECT_ID env var)"
  type        = string
  default     = null
}

variable "route53_hosted_zone_id" {
  description = "Route 53 hosted zone ID for proxy DNS record."
  type        = string
  default     = null
}

variable "idle_time_mins" {
  description = "Idle time in minutes after which to stop the RDS instance."
  type        = number
  default     = 10
}

variable "rds_instance_id" {
  description = "RDS instance identifier to manage with the AutoStopping rule."
  type        = string
}

variable "rds_target_port" {
  description = "RDS instance port to forward (e.g., 3306 for MySQL, 5432 for Postgres)."
  type        = number
}

variable "proxy_source_port" {
  description = "External source port exposed by the proxy (connect_on)."
  type        = number
  default     = 20000
}
