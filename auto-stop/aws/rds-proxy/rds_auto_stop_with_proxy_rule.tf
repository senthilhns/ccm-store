# Create Harness AutoStopping proxy and RDS rule using TCP forwarding

locals {
  // Ensure proxy name complies with provider limit (max 20 chars)
  proxy_name = substr("${var.schedule_name}-prx", 0, 20)
}

resource "harness_autostopping_aws_proxy" "main" {
  name                              = local.proxy_name
  cloud_connector_id                = var.cloud_connector_id
  region                            = var.region
  vpc                               = var.vpc_id
  host_name                         = local.proxy_name
  machine_type                      = var.proxy_machine_type
  api_key                           = var.harness_api_key
  security_groups                   = local.use_builtin_sg ? [aws_security_group.open_all[0].id] : var.security_group_ids
  # route53_hosted_zone_id            = var.route53_hosted_zone_id
  allocate_static_ip                = true
  keypair                           = var.key_pair_name
  delete_cloud_resources_on_destroy = true
}

resource "harness_autostopping_rule_rds" "main_tcp_proxy_rule" {
  name               = "${var.schedule_name}-rds-proxy-rule"
  cloud_connector_id = var.cloud_connector_id
  idle_time_mins     = var.idle_time_mins

  database {
    id     = var.rds_instance_id
    region = var.region
  }

  tcp {
    proxy_id = harness_autostopping_aws_proxy.main.id
    forward_rule {
      port       = var.rds_target_port
      connect_on = var.proxy_source_port
    }
  }
}
