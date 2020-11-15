variable "name" { }
variable "ami" {
  type = string
  default = "ami-09dd2e08d601bff67"
}
variable "instance_type" {}
variable "spot_type" {}
variable "spot_price" {}
variable "public_key" {}
variable "volume_size" {}
