output "vm_ids" {
  value = [for vm in data.azurerm_resources.vm_instances.resources : vm.id]
  description = "List of Azure VM resource IDs with the specified Schedule tag"
}