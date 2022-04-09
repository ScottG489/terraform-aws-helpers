resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]
  key_name = aws_key_pair.key_pair.key_name

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.volume_size
  }

  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "security_group" {
  name = var.name
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.name
  public_key = var.public_key
}
