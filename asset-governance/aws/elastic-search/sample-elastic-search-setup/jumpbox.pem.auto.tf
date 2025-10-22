resource "local_file" "jumpbox_private_key" {
  content              = tls_private_key.jumpbox.private_key_pem
  filename             = "${path.module}/jumpbox.pem"
  file_permission      = "0600"
  directory_permission = "0700"
}
