resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "website_bucket" {
  depends_on = [
    aws_s3_bucket_public_access_block.website_bucket,
    aws_s3_bucket_ownership_controls.website_bucket,
  ]

  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "website_bucket" {
  depends_on = [
    aws_s3_bucket_acl.website_bucket,
  ]

  bucket = aws_s3_bucket.website_bucket.id
  policy = templatefile("${path.module}/policy-template.json", { bucket_name: var.bucket_name })
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

resource "aws_s3_bucket_public_access_block" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
