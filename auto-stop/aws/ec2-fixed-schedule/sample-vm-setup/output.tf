output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "private_key_pem" {
  description = "PEM-encoded private key for SSH access (sensitive)"
  value       = tls_private_key.ec2_key.private_key_pem
  sensitive   = true
}

output "key_pair_name" {
  description = "The name of the SSH key pair created in AWS"
  value       = aws_key_pair.ec2_key_pair.key_name
}
