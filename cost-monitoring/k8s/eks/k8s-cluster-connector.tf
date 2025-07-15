# Contains k8s cluster connector, this is not the CCM connector

resource "harness_platform_connector_kubernetes" "inheritFromDelegate" {
  count        = var.is_add_k8s_cluster_connector ? 1 : 0
  identifier   = local.cloud_connector_name
  name         = "${local.cloud_connector_name}_cluster_connector"
  description  = "${local.cloud_connector_name} cluster connector"
  tags         = ["env:dev"]

  inherit_from_delegate {
    delegate_selectors = [local.delegate_name]
  }

  depends_on = [module.delegate]
}

/*
resource "harness_platform_connector_kubernetes" "serviceAccount" {
  identifier  = "identifier"
  name        = "name"
  description = "description"
  tags        = ["foo:bar"]

  service_account {
    master_url                = "https://kubernetes.example.com"
    service_account_token_ref = "account.TEST_k8s_client_test"
  }
  delegate_selectors = [local.delegate_name]
}
*/

/*
// Not helpful for managed clusters
resource "harness_platform_connector_kubernetes" "clientKeyCert" {
  identifier  = "identifier"
  name        = "name"
  description = "description"
  tags        = ["foo:bar"]

  client_key_cert {
    master_url                = "https://kubernetes.example.com"
    ca_cert_ref               = "account.TEST_k8ss_client_stuff"
    client_cert_ref           = "account.test_k8s_client_cert"
    client_key_ref            = "account.TEST_k8s_client_key"
    client_key_passphrase_ref = "account.TEST_k8s_client_test"
    client_key_algorithm      = "RSA"
  }

  delegate_selectors = [local.delegate_name]
}
*/

/*
// Only for legacy clusters
resource "harness_platform_connector_kubernetes" "usernamePassword" {
  identifier  = "identifier"
  name        = "name"
  description = "description"
  tags        = ["foo:bar"]

  username_password {
    master_url   = "https://kubernetes.example.com"
    username     = "admin"
    password_ref = "account.TEST_k8s_client_test"
  }

  delegate_selectors = [local.delegate_name]
}
*/

/*
resource "harness_platform_connector_kubernetes" "openIDConnect" {
  identifier  = "%[1]s"
  name        = "%[2]s"
  description = "description"
  tags        = ["foo:bar"]

  openid_connect {
    master_url    = "https://kubernetes.example.com"
    issuer_url    = "https://oidc.example.com"
    username_ref  = "account.TEST_k8s_client_test"
    client_id_ref = "account.TEST_k8s_client_test"
    password_ref  = "account.TEST_k8s_client_test"
    secret_ref    = "account.TEST_k8s_client_test"
    scopes = [
      "scope1",
      "scope2"
    ]
  }

  delegate_selectors = [local.delegate_name]
}
*/
