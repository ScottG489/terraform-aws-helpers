variable "name" { }
variable "ami" {
  type = string
  default = "ami-09dd2e08d601bff67"
}
variable "instance_type" {}
variable "volume_size" {
  type = number
  default = 50
}
variable "public_key" {}
