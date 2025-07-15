locals {
  safe_name_prefix      = replace(lower(var.name_prefix), "-", "_")
  delegate_name         = lower("${var.name_prefix}delegate")
  cloud_connector_name  = "${local.safe_name_prefix}_connector"
}