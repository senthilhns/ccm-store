#
# Create proxy and rule
#

resource "aws_instance" "proxy" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_pair_name
  subnet_id              = var.subnet_id
}

resource "aws_acm_certificate" "proxy" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}

resource "harness_autostopping_aws_proxy" "main" {
  name                              = "${var.schedule_name}-proxy"
  cloud_connector_id                = var.cloud_connector_id
  region                            = var.region
  vpc                               = var.vpc_id
  host_name                         = "${var.schedule_name}-proxy"
  machine_type                      = var.proxy_machine_type
  api_key                           = var.harness_api_key
  security_groups                   = var.security_group_ids
  route53_hosted_zone_id            = var.route53_hosted_zone_id
  allocate_static_ip                = true
  keypair                           = var.key_pair_name
  delete_cloud_resources_on_destroy = true
}

resource "harness_autostopping_rule_vm" "main_tcp_proxy_rule" {
  count             = var.use_tcp_proxy ? 1 : 0
  name              = "${var.schedule_name}-proxy-rule"
  cloud_connector_id = var.cloud_connector_id
  idle_time_mins    = 10
  filter {
    vm_ids  = [aws_instance.proxy.id]
    regions = [var.region]
  }
  tcp {
    proxy_id = harness_autostopping_aws_proxy.main.id
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
  name              = "${var.schedule_name}-proxy-rule"
  cloud_connector_id = var.cloud_connector_id
  idle_time_mins    = 10
  filter {
    vm_ids  = [aws_instance.proxy.id]
    regions = [var.region]
  }
  http {
    proxy_id = harness_autostopping_aws_proxy.main.id
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