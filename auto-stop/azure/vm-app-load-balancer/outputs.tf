output "alb_public_ip" {
  description = "The public IP address of the Application Load Balancer."
  value       = var.public_ip ? azurerm_public_ip.alb_frontend_sku1_ip[0].ip_address : null
}

output "alb_id" {
  value = azurerm_application_gateway.alb.id
}

output "alb_certificate_id" {
  value     = tolist(azurerm_application_gateway.alb.ssl_certificate)[0].id
  sensitive = true
}
