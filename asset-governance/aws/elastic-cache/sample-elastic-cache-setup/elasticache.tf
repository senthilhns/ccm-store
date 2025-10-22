resource "aws_elasticache_cluster" "sample" {
  cluster_id           = "${var.stack_prefix_id}-${var.cluster_id}"
  engine               = var.engine
  engine_version       = "6.2"
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = "default.redis6.x"
  subnet_group_name    = aws_elasticache_subnet_group.sample.name
  port                 = var.port
  security_group_ids   = [aws_security_group.elasticache_public.id]
  tags = merge({
    Name        = "${var.stack_prefix_id}-${var.tags["Name"]}"
    Environment = "${var.stack_prefix_id}-${var.tags["Environment"]}"
    Purpose     = "${var.stack_prefix_id}-${var.tags["Purpose"]}"
    StackPrefix = var.stack_prefix_id
  }, var.tags)
}
