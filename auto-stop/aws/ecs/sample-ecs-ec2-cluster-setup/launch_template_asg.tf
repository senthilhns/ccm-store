resource "aws_launch_template" "ecs" {
  name_prefix   = "${var.launch_template_name}-"
  image_id      = local.effective_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ecs_key_pair.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  network_interfaces {
    security_groups             = [aws_security_group.ecs.id]
    associate_public_ip_address = true
  }

  user_data = base64encode(local.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name     = "${var.cluster_name}-node"
      Schedule = var.schedule_tag
    }
  }
}

resource "aws_autoscaling_group" "ecs" {
  name                = var.asg_name
  vpc_zone_identifier = var.subnet_ids

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  health_check_type = "EC2"
  force_delete      = true

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "Schedule"
    value               = var.schedule_tag
    propagate_at_launch = true
  }
}
