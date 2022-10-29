# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.env}-vpc"
  }
}
# public subnet
resource "aws_subnet" "public-subnet" {
  count = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-public-${count.index}"
  }
}
# internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-main-gw"
  }
}
# public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "${var.env}-public"
  }
}
# route associations public
resource "aws_route_table_association" "public-route" {
  count = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-route-table.id
}
# private subnet
resource "aws_subnet" "private-subnet" {
  count = length(var.private_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-private-${count.index}"
  }
}
# EIP for NAT
resource "aws_eip" "nat" {
  vpc = true
}
# NAT GW
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public-subnet[2].id
}
# private route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
      Name = "${var.env}-private"
  }
}
# route associations private
resource "aws_route_table_association" "private-route" {
  count = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-route-table.id
}