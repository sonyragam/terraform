resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr_block
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_block
  }
}

resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = var.key_name

  connection {
    type        = "ssh"
    user        = var.ubuntu
    private_key = file("terraform_sony")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install apache2 -y",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]
  }

  provisioner "file" {
    source      = "app.html"
    destination = "/tmp/app.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/app.html /var/www/html/index.html"
    ]
  }

  tags = {
    Name = "terraform-ec2"
  }
}