resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "VPC200820"
  }

}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.sn_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "VPC200820 Subnet A"
  }

}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "VPC IGW 200820"
  }

}

resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.open_internet
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "RT for VPC200820"
  }

}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.vpc_rt.id
}
