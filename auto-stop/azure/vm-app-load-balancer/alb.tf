# resource "azurerm_public_ip" "alb_frontend_ip" {
#   count               = var.public_ip ? 1 : 0
#   name                = "${var.deployment_name}-as-alb-static-pip"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Basic"
# }

resource "azurerm_public_ip" "alb_frontend_sku1_ip" {
  count               = var.public_ip ? 1 : 0
  name                = "${var.deployment_name}-as-alb-sku1-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static" # Must be Static for Standard SKU
  sku                 = "Standard" # Must be Standard for Application Gateway
  zones               = ["1", "2", "3"] # Make the public IP zonal to match the Application Gateway
}

resource "azurerm_application_gateway" "alb" {
  name                = "${var.deployment_name}-gw"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Basic"
    tier     = "Basic"
    capacity = 2
    # family = "Generation_1" # Not supported in Terraform, Azure assigns automatically
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.alb_appgw_subnet.id
  }

  frontend_port {
    name = "port_80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appGwPublicFrontendIpIPv4"
    public_ip_address_id = azurerm_public_ip.alb_frontend_sku1_ip[0].id
  }

  backend_address_pool {
    name = "alb-backend-pool"
    ip_addresses = [var.target_vm_public_ip]
  }

  backend_http_settings {
    name                                = "alb-backend-settings"
    cookie_based_affinity               = "Disabled"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 20
    pick_host_name_from_backend_address = false
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
    frontend_port_name             = "port_80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "alb-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "alb-backend-pool"
    backend_http_settings_name = "alb-backend-settings"
    priority                   = 5000
  }

  enable_http2 = true
  zones = ["1", "2", "3"]
  ssl_policy {
    policy_name = "AppGwSslPolicy20220101"
  }

  frontend_port {
    name = "port_443"
    port = 443
  }

  backend_http_settings {
    name                  = "alb-backend-https-settings"
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 20
  }

  http_listener {
    name                           = "https-listener"
    frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
    frontend_port_name             = "port_443"
    protocol                       = "Https"
    ssl_certificate_name           = "appgw-cert"
  }

  request_routing_rule {
    name                       = "https-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "https-listener"
    backend_address_pool_name  = "alb-backend-pool"
    backend_http_settings_name = "alb-backend-https-settings"
    priority                   = 2000
  }

  ssl_certificate {
    name     = "appgw-cert"
    data = filebase64("appgw-cert.pfx")
    password = var.alb_cert_password
  }
}