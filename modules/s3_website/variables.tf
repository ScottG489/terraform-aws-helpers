variable "name" {
  type = string
}

variable "subdomain" {
  type = string
  default = "www"
}

variable "subdomain_redirect_protocol" {
  type = string
  default = "http"
}
