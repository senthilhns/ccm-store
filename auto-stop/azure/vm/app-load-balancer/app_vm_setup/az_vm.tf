resource "azurerm_linux_virtual_machine" "main" {
  name                  = "${var.deployment_name}-vm"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  disable_password_authentication = true
  network_interface_ids = [azurerm_network_interface.main.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.disk_type
    name                 = "${var.deployment_name}-osdisk"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("az_vm_ssh_key.pub")
  }
  custom_data = filebase64("app-vm-init.sh")
  tags        = var.tags
}
