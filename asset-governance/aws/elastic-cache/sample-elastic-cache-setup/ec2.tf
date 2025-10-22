resource "aws_instance" "redis_test" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.elasticache_public.id]
  associate_public_ip_address = true
  key_name               = aws_key_pair.ec2_key.key_name
  tags = {
    Name        = "${var.stack_prefix_id}-redis-test-ec2"
    StackPrefix = var.stack_prefix_id
  }

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y redis-tools
  EOF
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

output "ec2_public_ip" {
  value = aws_instance.redis_test.public_ip
}
