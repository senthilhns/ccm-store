resource "azurerm_ssh_public_key" "proxy_test_key" {
  name                = "hns-proxy-test-key"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  public_key          = file("az_vm_ssh_key.pub")
  depends_on          = [azurerm_resource_group.main]
}
