resource "aws_route53_record" "website_r53_record_A_top" {
  zone_id = var.route53_zone_id
  name    = ""
  type    = "A"

  alias {
    zone_id                = var.s3_website_hosted_zone_id
    name                   = var.s3_website_record_alias_name
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "website_record_A_www" {
  zone_id = var.route53_zone_id
  name    = var.subdomain
  type    = "A"

  alias {
    zone_id                = var.s3_website_hosted_zone_id
    name                   = var.s3_website_record_alias_name
    evaluate_target_health = false
  }
}
