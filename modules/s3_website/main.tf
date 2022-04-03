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
  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = templatefile("${path.module}/policy-template.json", { bucket_name: var.name })
}

resource "aws_s3_bucket" "www_website_bucket" {
    bucket = "${var.subdomain}.${var.name}"
}

resource "aws_s3_bucket_website_configuration" "www_website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id
  redirect_all_requests_to {
    host_name = aws_s3_bucket.website_bucket.bucket
    protocol = var.subdomain_redirect_protocol
  }
}
