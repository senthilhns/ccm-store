resource "tls_private_key" "jumpbox" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "jumpbox" {
  key_name   = "opensearch-jumpbox-key"
  public_key = tls_private_key.jumpbox.public_key_openssh
}

output "jumpbox_private_key_pem" {
  description = "Private key for SSH access to the jumpbox EC2 instance. Save this as a .pem file."
  value       = tls_private_key.jumpbox.private_key_pem
  sensitive   = true
}
