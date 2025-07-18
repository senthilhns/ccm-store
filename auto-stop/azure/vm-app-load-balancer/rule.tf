# import existing azure application gateway
resource "harness_autostopping_azure_gateway" "hns_azure_gateway_import" {
  count                              = var.is_create_auto_stop_rule ? 1 : 0
  name                              = "hns_azure_gateway_import"
  cloud_connector_id                = var.harness_cloud_connector_id
  host_name                         = "hns_azure_gateway_import_host"
  region                            = var.location
  resource_group                    = var.resource_group_name
  app_gateway_id                    = var.app_gateway_id
  certificate_id                    = var.alb_certificate_id
  azure_func_region                 = var.location
  vpc                               = azurerm_virtual_network.alb_vnet.id
  delete_cloud_resources_on_destroy = false
}


resource "harness_autostopping_rule_vm" "rule" {
  count               = var.is_create_auto_stop_rule ? 1 : 0
  name               = "${var.resource_group_name}-ec2-rule"
  cloud_connector_id = var.harness_cloud_connector_id
  idle_time_mins     = 5
  filter {
    vm_ids  = [var.target_vm_id]
    regions = [var.location]
  }
  http {
    proxy_id = harness_autostopping_azure_gateway.hns_azure_gateway_import[0].id
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
  #custom_domains = [local.lb_hostname]
}
