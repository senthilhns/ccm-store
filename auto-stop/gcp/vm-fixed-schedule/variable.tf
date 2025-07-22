variable "schedule_tag_key" {
  description = "The key for the tag/label e.g schedule in gcp it should be lower case"
  type        = string
}

variable "schedule_name_tag" {
  description = "The value of the Schedule label to filter VM instances."
  type        = string
}

variable "schedule_name" {
  description = "The name of the schedule for the autostopping rule."
  type        = string
}

variable "project_id" {
  description = "The GCP project ID to use for VM discovery."
  type        = string
}

variable "add_vm_schedule_rules" {
  description = "Whether to add Harness autostopping rules for VMs with the schedule label."
  type        = bool
  default     = true
}

variable "harness_cloud_connector_id" {
  description = "The Harness Cloud Connector ID to use for the autostopping rule."
  type        = string
}

variable "time_zone" {
  description = "The time zone to use for the autostopping schedule (e.g., Asia/Kolkata)."
  type        = string
}

variable "zone" {
  description = "The GCP zone for the VM resources (e.g., asia-south1-a)."
  type        = string
}
