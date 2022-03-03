output "spot_instance_id" {
  value = aws_spot_instance_request.spot_instance_request.spot_instance_id
}

output "public_ip" {
  value = aws_spot_instance_request.spot_instance_request.public_ip
}

output "public_dns" {
  value = aws_spot_instance_request.spot_instance_request.public_dns
}
