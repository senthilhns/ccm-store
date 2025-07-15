#
# Create proxy and rule
#

resource "harness_autostopping_azure_proxy" "main" {
  name                              = "${var.resource_group_name}-proxy"
  cloud_connector_id                = var.cloud_connector_id
  host_name                         = var.host_name
  region                            = var.location
  resource_group                    = var.resource_group_name
  vpc                               = var.vnet
  subnet_id                         = var.subnet_id
  security_groups                   = var.security_groups
  allocate_static_ip                = var.allocate_static_ip
  machine_type                      = var.machine_type
  keypair                           = var.keypair
  api_key                           = var.api_key
  certificates {
    cert_secret_id = azurerm_key_vault_secret.proxy_cert.id
    key_secret_id  = azurerm_key_vault_secret.proxy_key.id
  }
 delete_cloud_resources_on_destroy = var.delete_cloud_resources_on_destroy
}

resource "harness_autostopping_rule_vm" "main_tcp_proxy_rule" {
  count             = var.use_tcp_proxy ? 1 : 0
  name               = "${var.resource_group_name}-proxy-rule"
  cloud_connector_id = var.cloud_connector_id
  idle_time_mins     = 10
  filter {
    vm_ids  = [var.vm_id]
    regions = [var.location]
  }
  tcp {
    proxy_id = harness_autostopping_azure_proxy.main.id
    ssh {
      port = 22
    }
    forward_rule {
      port = 80
    }
    forward_rule {
      port = 443
    }
  }
}

resource "harness_autostopping_rule_vm" "main_http_proxy_rule" {
  count = var.use_https_proxy ? 1 : 0
  name               = "${var.resource_group_name}-proxy-rule"
  cloud_connector_id = var.cloud_connector_id
  idle_time_mins     = 10
  filter {
    vm_ids  = [var.vm_id]
    regions = [var.location]
  }
  http {
    proxy_id = harness_autostopping_azure_proxy.main.id
    routing {
      source_protocol = "https"
      target_protocol = "https"
      source_port     = 443
      target_port     = 443
      action          = "forward"
    }
    routing {
      source_protocol = "http"
      target_protocol = "http"
      source_port     = 80
      target_port     = 80
      action          = "forward"
    }
    health {
      protocol         = "http"
      port             = 80
      path             = "/"
      timeout          = 30
      status_code_from = 200
      status_code_to   = 299
    }
  }
}
