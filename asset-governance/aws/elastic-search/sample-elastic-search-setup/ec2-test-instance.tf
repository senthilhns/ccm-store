resource "aws_instance" "opensearch_test" {
  ami                    = "ami-0c1a7f89451184c8b" # Amazon Linux 2 for ap-south-1
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.opensearch_test_sg.id]
  associate_public_ip_address = true
  key_name               = aws_key_pair.jumpbox.key_name
  tags = merge(var.tags, { Name = "opensearch-test-instance" })
}

resource "aws_security_group" "opensearch_test_sg" {
  name        = "${var.stack_prefix_id}-opensearch-test-sg"
  description = "Allow SSH and HTTPS for test EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.stack_prefix_id}-opensearch-test-sg" })
}
