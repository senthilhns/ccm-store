resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name       = "${var.stack_prefix_id}-${var.subnet_group_name}"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    "Name"        = "${var.stack_prefix_id}-${var.subnet_group_name}",
    "StackPrefix" = var.stack_prefix_id
  })
}
