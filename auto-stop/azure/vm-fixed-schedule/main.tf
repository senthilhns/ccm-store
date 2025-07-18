locals {
  locations = [var.location]
  # Map of "<resource_group_name>-<vm_name>" to resource ID for use in for_each
  vm_name_to_id = {
    for vm in data.azurerm_resources.vm_instances.resources :
    "${split("/", vm.id)[8]}--${split("/", vm.id)[4]}" => vm.id
  }
}

