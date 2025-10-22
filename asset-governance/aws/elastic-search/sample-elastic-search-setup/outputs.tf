output "domain_arn" {
  description = "ARN of the OpenSearch domain"
  value       = aws_opensearch_domain.opensearch.arn
}

output "domain_id" {
  description = "ID of the OpenSearch domain"
  value       = aws_opensearch_domain.opensearch.domain_id
}

output "domain_endpoint" {
  description = "Endpoint for the OpenSearch domain"
  value       = aws_opensearch_domain.opensearch.endpoint
}

output "kibana_endpoint" {
  description = "Kibana endpoint for the OpenSearch domain"
  value       = aws_opensearch_domain.opensearch.kibana_endpoint
}

output "jumpbox_public_ip" {
  description = "Public IP address of the jumpbox EC2 instance"
  value       = aws_instance.opensearch_test.public_ip
}
