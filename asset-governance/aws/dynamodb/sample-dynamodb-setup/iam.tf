# IAM policy that allows public access to DynamoDB
resource "aws_iam_policy" "dynamodb_public_access" {
  name        = "${var.table_name}-public-access"
  description = "Policy that allows public access to DynamoDB table ${var.table_name}"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem"
        ]
        Resource = [
          "arn:aws:dynamodb:${var.aws_region}:*:table/${var.table_name}",
          "arn:aws:dynamodb:${var.aws_region}:*:table/${var.table_name}/index/*"
        ]
      }
    ]
  })
}
