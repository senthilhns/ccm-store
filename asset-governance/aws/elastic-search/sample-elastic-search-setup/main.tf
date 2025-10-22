resource "aws_security_group" "opensearch_sg" {
  name        = "${var.stack_prefix_id}-opensearch-sg"
  description = "Security group for OpenSearch"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.stack_prefix_id}-opensearch-sg"
    }
  )
}

resource "aws_opensearch_domain" "opensearch" {
  domain_name           = "${var.stack_prefix_id}-${var.domain_name}"
  engine_version        = var.engine_version

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = { AWS = "*" }
        Action = "es:*"
        Resource = "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.stack_prefix_id}-${var.domain_name}/*"
        Condition = {
          StringEquals = {
            "aws:AuthType" = "SIGV4"
          }
        }
      }
    ]
  })

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    dedicated_master_enabled = false
    zone_awareness_enabled   = var.instance_count > 1

    zone_awareness_config {
      availability_zone_count = var.instance_count
    }
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  vpc_options {
    subnet_ids = var.subnet_ids
    security_group_ids = [aws_security_group.opensearch_sg.id]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.stack_prefix_id}-opensearch"
    }
  )
}
