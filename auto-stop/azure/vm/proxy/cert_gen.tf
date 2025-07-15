# Generate a self-signed TLS certificate and private key
resource "tls_private_key" "proxy" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  content  = tls_private_key.proxy.private_key_pem
  filename = "proxy_private_key.pem"
}

resource "tls_self_signed_cert" "proxy" {
  private_key_pem = tls_private_key.proxy.private_key_pem
  subject {
    common_name  = "proxy.example.local"
    organization = "ExampleOrg"
  }
  validity_period_hours = 8760 # 1 year
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth"
  ]
}
#
# resource "azurerm_resource_group" "proxy" {
#   name     = var.resource_group_name
#   location = var.location
# }

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "proxy" {
  name                        = "pxykv-${substr(var.resource_group_name, 0, 16)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
}

resource "azurerm_key_vault_access_policy" "full_access" {
  for_each     = toset(local.key_vault_access_object_ids)
  key_vault_id = azurerm_key_vault.proxy.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
  ]

  key_permissions = [
    "Get", "List", "Create", "Update", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt",
    "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge"
  ]

  certificate_permissions = [
    "Get", "List", "Delete", "Create", "Import", "Update", "ManageContacts", "ManageIssuers", "GetIssuers",
    "ListIssuers", "SetIssuers", "DeleteIssuers", "Recover", "Backup", "Restore", "Purge"
  ]

  storage_permissions = [
    "Get", "List", "Delete", "Set", "Update", "RegenerateKey", "Recover", "Backup", "Restore", "Purge",
    "SetSAS", "ListSAS", "GetSAS", "DeleteSAS"
  ]
}

# Store the certificate and key in Azure Key Vault
resource "azurerm_key_vault_secret" "proxy_cert" {
  name         = "proxy-cert-fullchain-${var.resource_group_name}"
  value        = tls_self_signed_cert.proxy.cert_pem
  key_vault_id = azurerm_key_vault.proxy.id
  depends_on = [azurerm_key_vault_access_policy.full_access]
}

resource "azurerm_key_vault_secret" "proxy_key" {
  name         = "proxy-cert-privkey-${var.resource_group_name}"
  value        = tls_private_key.proxy.private_key_pem
  key_vault_id = azurerm_key_vault.proxy.id
  depends_on = [azurerm_key_vault_access_policy.full_access]
}
