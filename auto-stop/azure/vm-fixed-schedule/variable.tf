// Defines Terraform variables for configuring scheduling rules in Azure VM environments.
// Terraform variables for scheduling rules

variable "location" {
  type        = string
  description = "Azure location to deploy resources in"
}

variable "harness_cloud_connector_id" {
  type    = string
  default = "Harness CCM connector for target Azure account"
}

variable "schedule_name_tag" {
  type    = string
  default = null
}

variable "add_az_vm_schedule_rules" {
  type        = bool
  description = "Whether to create Azure VM schedule rules in Harness"
  default     = false
}

variable "schedule_name" {
  type        = string
  description = "Name of the schedule to be created"
}

variable "time_zone" {
  type        = string
  description = "Time zone for the schedule"
}