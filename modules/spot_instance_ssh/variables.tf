variable "name" { }
variable "ami" {
  type = string
  default = "www"
}
variable "instance_type" {}
variable "spot_type" {}
variable "spot_price" {}
variable "public_key" {}
variable "volume_size" {}
