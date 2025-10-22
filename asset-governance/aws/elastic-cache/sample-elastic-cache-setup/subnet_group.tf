resource "aws_elasticache_subnet_group" "sample" {
  name        = "${var.stack_prefix_id}-${var.subnet_group_name}"
  subnet_ids  = var.subnet_ids
  description = "${var.stack_prefix_id} Sample subnet group for minimal ElastiCache setup."
  tags = {
    Name        = "${var.stack_prefix_id}-${var.subnet_group_name}"
    StackPrefix = var.stack_prefix_id
  }
}
