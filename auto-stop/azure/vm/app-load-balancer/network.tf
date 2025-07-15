resource "azurerm_virtual_network" "alb_vnet" {
  name                = "${var.deployment_name}-alb-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "alb_appgw_subnet" {
  name                 = "${var.deployment_name}-appgw-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.alb_vnet.name
  address_prefixes     = ["10.0.2.0/25"] # 128 IPs
}
