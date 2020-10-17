resource "aws_s3_bucket" "website_bucket" {
  bucket = var.name
  acl    = "public-read"
  policy = templatefile("${path.module}/policy-template.json", { bucket_name: var.name })
  force_destroy = true

  website {
    index_document = "index.html"
  }
}

resource "aws_route53_record" "website_record_A_www" {
  zone_id = var.route53_zone_id
  name    = var.subdomain
  type    = "A"

  alias {
    zone_id                = aws_s3_bucket.website_bucket.hosted_zone_id
    name                   = "s3-website-us-west-2.amazonaws.com"
    evaluate_target_health = false
  }
}
