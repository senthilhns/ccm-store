variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group."
}

variable "location" {
  type        = string
  description = "Azure region to deploy resources in."
  default     = "Central India"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM."
  default     = "azureuser"
}

variable "vm_size" {
  type        = string
  description = "Azure VM size. Default is Standard_B1ls."
  default     = "Standard_B1ls"
}

variable "os_disk_size_gb" {
  type        = number
  description = "Size of the OS disk in GB."
  default     = 30
}

variable "disk_type" {
  type        = string
  description = "Type of managed disk (Standard_LRS, Premium_LRS, etc.)."
  default     = "Standard_LRS"
}

variable "public_ip" {
  type        = bool
  description = "Whether to assign a public IP to the VM."
  default     = true
}

variable "custom_data" {
  type        = string
  description = "cloud-init script for provisioning (base64 encoded)."
  default     = null
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
