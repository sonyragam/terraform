provider "aws" {
  region = "ap-south-1"
}
#### Vpc creation ########
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
  tags = {
    Name= "test_vpc"
  }
}
######### subnet creation inside vpc ##########

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true 
    tags = {
    Name = "public-subnet"
  }
}
######### Rote table with igw #############

resource "aws_route_table" "publicroute" {
    vpc_id = aws_vpc.vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    } 
        tags = {
            Name = "public_route" 
            }  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags ={
        Name = "igw"
    }
  
}

######## subnet assocation with publicroute #########
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.publicroute.id
}

######ec2 instance ######
 resource "aws_instance" "ec2" {
    ami = "ami-019715e0d74f695be"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.subnet1.id

    key_name = aws_key_pair.terraform_key.key_name
    depends_on = [aws_internet_gateway.igw]
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "terrafrom ec2"
    } 
    connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("terraform_sony")
    host        = self.public_ip
    timeout = "2m"
  } 

# SSH connection


  # Install Apache
provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install apache2 -y",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]
  }

  # Copy HTML file
provisioner "file" {
    source      = "app.html"
    destination = "/tmp/app.html"
  }

  # Move file to Apache folder
provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/app.html /var/www/html/index.html"
    ]
  }

 }

 resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-sony-key"
  public_key = file("terraform_sony.pub")
}

###### SECURITY GROUP #########
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
  }

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}