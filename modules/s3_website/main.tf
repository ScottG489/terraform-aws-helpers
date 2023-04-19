resource "aws_s3_bucket" "website_bucket" {
  bucket = var.name
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
  policy = templatefile("${path.module}/policy-template.json", { bucket_name: var.name })
}

resource "aws_s3_bucket" "www_website_bucket" {
    bucket = "${var.subdomain}.${var.name}"
}

resource "aws_s3_bucket_website_configuration" "www_website_bucket" {
  bucket = aws_s3_bucket.www_website_bucket.id
  redirect_all_requests_to {
    host_name = aws_s3_bucket.website_bucket.bucket
    protocol = var.subdomain_redirect_protocol
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
