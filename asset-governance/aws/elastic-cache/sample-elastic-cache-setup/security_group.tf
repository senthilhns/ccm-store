resource "aws_security_group" "elasticache_public" {
  name        = "${var.stack_prefix_id}-Elasticache-public-sg"
  description = "Allow public access to ElastiCache cluster and EC2 test instance (not recommended for production)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.stack_prefix_id}-Elasticache-public-sg"
    StackPrefix = var.stack_prefix_id
  }
}
