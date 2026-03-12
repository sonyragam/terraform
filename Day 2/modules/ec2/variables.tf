variable "ami" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "key_name" {}
variable "ubuntu" {}
variable "cidr_block" {
  type = list(string)
}