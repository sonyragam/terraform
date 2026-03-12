variable "vpc" {
  default = "10.0.0.0/16"
}

variable "subnet" {
  default = "10.0.1.0/24"
}

variable "ami" {
  default = "ami-019715e0d74f695be"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ubuntu" {
  default = "ubuntu"
}

variable "cidr_block" {
  type = list(string)
  default = ["0.0.0.0/0"]
}
variable "region" {
    default = "ap-south-1"
  
}