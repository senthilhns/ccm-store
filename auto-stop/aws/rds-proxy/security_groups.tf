# Security group that opens all traffic, created only when no SGs are provided

locals {
  use_builtin_sg = length(var.security_group_ids) == 0
}

resource "aws_security_group" "open_all" {
  count       = local.use_builtin_sg ? 1 : 0
  name        = "${var.schedule_name}-rds-proxy-open-all"
  description = "Open all ports inbound/outbound for RDS proxy"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
