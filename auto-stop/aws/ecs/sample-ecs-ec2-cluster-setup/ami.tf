# Automatic AMI lookup for ECS-optimized Amazon Linux 2
# If var.ami_id is provided (non-empty), it will be used. Otherwise, use the SSM-recommended image.

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

locals {
  effective_ami_id = var.ami_id != "" ? var.ami_id : data.aws_ssm_parameter.ecs_ami.value
}
