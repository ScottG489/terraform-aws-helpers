resource "aws_route53_record" "api_r53_record_A_top" {
  zone_id = var.route53_zone_id
  name    = ""
  records = [
    var.public_ip
  ]
  ttl     = 300
  type    = "A"
}

resource "aws_route53_record" "api_r53_record_A_api" {
  zone_id = var.route53_zone_id
  name    = "api"
  records = [
    var.public_ip
  ]
  ttl     = 300
  type    = "A"
}
