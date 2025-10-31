variable "cloud_connector_id" {
  type        = string
  description = "Cloud connector ID for Harness autostopping integration."
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources in."
  default     = "ap-south-1"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the AWS EC2 key pair."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the EC2 instance."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance."
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of AWS Security Group IDs."
}

variable "allocate_eip" {
  type        = bool
  description = "Whether to allocate an Elastic IP."
  default     = true
}

variable "schedule_name" {
  description = "Name to set for the schedule indicating the schedule type."
  type        = string
}

variable "proxy_machine_type" {
  description = "Instance type for the proxy VM (e.g., t2.medium)."
  type        = string
}

variable "harness_api_key" {
  description = "Harness NG API key. Should be set from the HARNESS_PLATFORM_API_KEY environment variable."
  type        = string
  sensitive   = true
}

variable "route53_hosted_zone_id" {
  description = "Route 53 hosted zone ID for proxy DNS record."
  type        = string
}

variable "use_tcp_proxy" {
  description = "Whether to create a TCP proxy rule."
  type        = bool
  default     = false
}

variable "use_https_proxy" {
  description = "Whether to create an HTTPS proxy rule."
  type        = bool
  default     = false
}
