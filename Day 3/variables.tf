variable "instance_type" {
  default = {
    ec2-01 = "t3.micro"
    ec2-02 = "t3.small"
  }
}
variable "ami" {
  default = "ami-019715e0d74f695be"

}
variable "region" {
  default = "ap-south-1"
}