provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2" {
  #count = 3
  for_each      = var.instance_type
  ami           = var.ami
  instance_type = each.value
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

locals {
  ports = {
   ssh = "22"
   https = "443"
   http = "80"
  }
}

resource "aws_security_group" "web_sg" {
  name = "web-sg"
}


resource "aws_security_group_rule" "rule" {
    type = "ingress"
    for_each = local.ports
    from_port = each.value
    to_port = each.value
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.web_sg.id
  
}
  