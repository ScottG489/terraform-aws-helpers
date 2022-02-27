resource "aws_spot_instance_request" "spot_instance_request" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]
  key_name = aws_key_pair.key_pair.key_name

  spot_type = var.spot_type
  instance_interruption_behavior = var.instance_interruption_behavior
  spot_price    = var.spot_price
  wait_for_fulfillment = true
  valid_until = "2100-01-01T00:00:00Z"

  root_block_device {
    volume_type           = "gp2"
    // This doesn't do the resize but I'm leaving it. The update_instance_volume_size.sh is a workaround.
    volume_size           = var.volume_size
  }

  tags = {
    Name = var.name
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/create_instance_tag.sh ${aws_spot_instance_request.spot_instance_request.spot_instance_id} ${var.name}"
  }
}

resource "null_resource" "aws_spot_instance_volume_size" {
  triggers = {
    volume_size = var.volume_size
  }

  // TODO: This runs the first time and even though it's the same size it ends up running successfully.
  // TODO:   This means that it will then kick off the "optimize import" for the volume. It also means that
  // TODO:   you won't be able to update the volume size for another 6 hours. This could be fixed by manually
  // TODO:   checking if the size is the same as the current size and if so do nothing.
  provisioner "local-exec" {
    command = "${path.module}/scripts/update_instance_volume_size.sh ${aws_spot_instance_request.spot_instance_request.spot_instance_id} ${var.volume_size}"
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
