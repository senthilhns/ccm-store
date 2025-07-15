variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group."
}

variable "location" {
  type        = string
  description = "Azure region to deploy resources in."
  default     = "Central India"
}

variable "public_ip" {
  type        = bool
  description = "Whether to assign a public IP to the VM."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to resources."
  default     = {}
}

variable "deployment_name" {
  type        = string
  description = "A unique key to use for all resource names."
}

variable "target_vm_public_ip" {
  type        = string
  description = "Public IP address of the target VM."
}

variable "alb_cert_password" {
  type        = string
  description = "Password for the Azure Application Gateway certificate."
}

variable "harness_cloud_connector_id" {
  type        = string
  description = "Cloud connector ID for Harness autostopping integration."
}

variable app_gateway_id {
  type        = string
  description = "Azure Application Gateway ID."
}

variable "alb_certificate_id" {
  type        = string
  description = "Azure Application Gateway certificate ID."
  default     = ""
}

variable "target_vm_id" {
  type        = string
  description = "Azure VM ID."
  default     = ""
}

variable "is_create_auto_stop_rule" {
  type        = bool
  description = "Whether to create an auto-stop rule for the VM."
  default     = false
}