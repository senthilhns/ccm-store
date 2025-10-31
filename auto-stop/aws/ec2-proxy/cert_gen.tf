# Generate a self-signed TLS certificate and private key for AWS
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

resource "aws_acm_certificate" "proxy" {
  private_key       = tls_private_key.proxy.private_key_pem
  certificate_body  = tls_self_signed_cert.proxy.cert_pem
  validation_method = "DNS"
}
