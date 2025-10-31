output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.example.arn
}

output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.example.id
}

output "dynamodb_table_stream_arn" {
  description = "The ARN of the Table Stream"
  value       = aws_dynamodb_table.example.stream_arn
}

output "dynamodb_table_stream_label" {
  description = "A timestamp in RFC3339 format for the Table Stream"
  value       = aws_dynamodb_table.example.stream_label
}
