resource "aws_security_group" "redshift_public" {
  name        = "${var.stack_prefix_id}-${var.security_group_name}"
  description = "Allow public access to Redshift cluster for testing"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    "Name"        = "${var.stack_prefix_id}-${var.security_group_name}",
    "StackPrefix" = var.stack_prefix_id
  })
}
