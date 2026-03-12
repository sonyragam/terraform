resource "aws_vpc" "vpc" {
  cidr_block = var.vpc

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.publicroute.id
}