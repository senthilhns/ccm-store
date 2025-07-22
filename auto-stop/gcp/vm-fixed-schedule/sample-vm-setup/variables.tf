variable "zone" {
  description = "The zone to deploy the VM in."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the VM."
  type        = string
}

variable "stack_prefix" {
  description = "Prefix for resource names."
  type        = string
}

variable "schedule_tag_key" {
  description = "The key for the tag/label, e.g. 'schedule' (should be lower case for GCP)."
  type        = string
}

variable "schedule_tag_name" {
  description = "Value for the Schedule tag."
  type        = string
}

variable "project" {
  description = "The GCP project ID to deploy resources in."
  type        = string
}
