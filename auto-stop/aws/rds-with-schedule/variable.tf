// Defines Terraform variables for configuring scheduling rules in AWS EC2 and RDS environments.
// Terraform variables for scheduling rules

variable "region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region to deploy resources in"
}

variable "harness_cloud_connector_id" {
  type    = string
  default = "AWS CCM connector for target AWS account"
}

variable "schedule_name_tag" {
  type    = string
  description = "name of the schedule tag atached to the rds instance that will be searched for"
  default = null
}

variable "add_rds_schedule_rules" {
  type        = bool
  description = "Whether to create rds schedule rules in Harness"
  default     = false
}

variable "schedule_name" {
  type        = string
  description = "name to set for the schedule indicating the schedule type"
}

variable "time_zone" {
  type        = string
  description = "Time zone for the schedule"
}