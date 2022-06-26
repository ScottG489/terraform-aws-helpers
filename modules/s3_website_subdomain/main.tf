resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
  policy = templatefile("${path.module}/policy-template.json", { bucket_name: var.bucket_name })
  force_destroy = true

  website {
    index_document = "index.html"
  }
}

resource "aws_route53_record" "website_record_A" {
  zone_id = var.route53_zone_id
  name    = var.subdomain
  type    = "A"

  alias {
    zone_id                = var.s3_website_hosted_zone_id
    name                   = var.s3_website_record_alias_name
    evaluate_target_health = false
  }
}
