resource "harness_platform_connector_kubernetes_cloud_cost" "ccm" {
  identifier      = "${local.cloud_connector_name}_ccm_con"
  name            = "${local.cloud_connector_name} ccm connector"
  description     = "${local.cloud_connector_name} ccm connector"
  features_enabled = ["OPTIMIZATION", "VISIBILITY"]
  connector_ref   = local.cloud_connector_name
  depends_on      = [harness_platform_connector_kubernetes.inheritFromDelegate]
}
