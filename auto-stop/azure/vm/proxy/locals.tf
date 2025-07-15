locals {
  key_vault_access_object_ids = [
    var.this_tf_principal_id,
    var.harness_principal_id
  ]
}
