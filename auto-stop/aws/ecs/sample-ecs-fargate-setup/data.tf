# Get the current AWS region
data "aws_region" "current" {}

# Get the current AWS account ID
data "aws_caller_identity" "current" {}

# Get the VPC details
data "aws_vpc" "selected" {
  id = var.vpc_id
}

# Get subnet details
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  
  # Optionally filter by specific subnet IDs if provided
  dynamic "filter" {
    for_each = length(var.subnet_ids) > 0 ? [1] : []
    content {
      name   = "subnet-id"
      values = var.subnet_ids
    }
  }
}

# Get the latest ECS-optimized AMI (not needed for Fargate, but kept for reference)
# data "aws_ssm_parameter" "ecs_optimized_ami" {
#   name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
# }

# Get the default security group of the VPC (for reference)
data "aws_security_group" "default" {
  vpc_id = var.vpc_id
  name   = "default"
}

# Get the availability zones for the selected subnets
data "aws_subnet" "selected" {
  for_each = toset(var.subnet_ids)
  id       = each.value
}

locals {
  # Extract availability zones from the selected subnets
  availability_zones = [for s in data.aws_subnet.selected : s.availability_zone]
  
  # Common tags to be used for all resources
  common_tags = merge(
    var.tags,
    {
      Environment = "dev"
      ManagedBy   = "terraform"
      Project     = "ecs-fargate-demo"
    }
  )
}

# Get the current AWS partition (aws, aws-us-gov, aws-cn, etc.)
data "aws_partition" "current" {}
