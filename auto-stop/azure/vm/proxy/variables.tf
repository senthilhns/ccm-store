variable "cloud_connector_id" {
  type        = string
  description = "Cloud connector ID for Harness autostopping integration."
}

variable "host_name" {
  type        = string
  description = "Host name for the Azure proxy."
}

variable "location" {
  type        = string
  description = "Azure region to deploy resources in."
  default     = "Central India"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group."
}

variable "vnet" {
  type        = string
  description = "Azure Virtual Network name."
}

variable "subnet_id" {
  type        = string
  description = "Azure Subnet ID."
}

variable "security_groups" {
  type        = list(string)
  description = "List of Azure Network Security Group IDs."
}

variable "allocate_static_ip" {
  type        = bool
  description = "Whether to allocate a static public IP."
  default     = true
}

variable "machine_type" {
  type        = string
  description = "Azure VM machine type."
  default     = "Standard_D2s_v3"
}

variable "keypair" {
  type        = string
  description = "SSH keypair name or value."
  default     = ""
}

variable "api_key" {
  type        = string
  description = "API key for proxy integration (optional)."
  default     = ""
}

variable "delete_cloud_resources_on_destroy" {
  type        = bool
  description = "Whether to delete cloud resources when destroying the proxy."
  default     = true
}

variable "vm_id" {
  type        = string
  description = "Azure VM ID."
  default     = ""
}

variable "use_tcp_proxy" {
  type        = bool
  description = "Enable or disable TCP proxy rules (forwards SSH, 80, 443, etc) in the autostopping rule."
  default     = false
}

variable "use_https_proxy" {
  type        = bool
  description = "Enable or disable TCP proxy rules (forwards SSH, 80, 443, etc) in the autostopping rule."
  default     = false
}

variable "this_tf_principal_id" {
  description = "Object ID of the principal running Terraform (for Key Vault access)."
  type        = string
}

variable "harness_principal_id" {
  description = "Object ID of the Harness service principal (for Key Vault access)."
  type        = string
}
