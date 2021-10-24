variable "route53_zone_id" {
  type = string
}

variable "s3_website_hosted_zone_id" {
  type = string
}

variable "s3_website_record_alias_name" {
  type = string
  default = "s3-website-us-west-2.amazonaws.com"
}

variable "subdomain" {
  type = string
  default = "www"
}
