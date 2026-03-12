module "vpc" {
  source = "./modules/vpc"

  vpc    = var.vpc
  subnet = var.subnet
}

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform_sony"
  public_key = file("terraform_sony.pub")
}

module "ec2" {
  source = "./modules/ec2"

  subnet_id     = module.vpc.subnet_id
  vpc_id        = module.vpc.vpc_id
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.terraform_key.key_name
  ubuntu        = var.ubuntu
  cidr_block    = var.cidr_block
}