output "vm_id" {
  value = azurerm_linux_virtual_machine.main.id
}

output "vm_public_ip" {
  value = var.public_ip ? azurerm_public_ip.main[0].ip_address : null
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.main.name
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
