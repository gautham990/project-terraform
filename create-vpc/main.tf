terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "ap-southeast-1"
}
variable "cidr" {
  default = {
    "ap-southeast-1a" = "10.0.1.0/24"
    "ap-southeast-1b" = "10.0.2.0/24"
    "ap-southeast-1c" = "10.0.3.0/24"
  }
}
variable "az" {
  default = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}
resource "aws_vpc" "prod-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "prod-vpc"
  }
}
resource "aws_internet_gateway" "prod-IG" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "prod-IG"
  }
}
resource "aws_subnet" "prod-subnet" {
  vpc_id     = aws_vpc.prod-vpc.id
  availability_zone = var.az[count.index]
  cidr_block = var.cidr[var.az[count.index]]
  tags = {
    Name = var.az[count.index]
  }
  count = 3
}
resource "aws_route" "main-RT" {
  route_table_id = aws_vpc.prod-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.prod-IG.id
}
resource "aws_route_table_association" "rt-association" {
  route_table_id = aws_vpc.prod-vpc.main_route_table_id
  subnet_id      = aws_subnet.prod-subnet[count.index].id
  count = 3
}
/* code works till here */
variable "sec-groups-ports" {
  description = "Allowed ports"
  type        = list
  default     = [443,80,22]
}
resource "aws_security_group" "web-server" {
  name        = "web-server"
  description = "Allows web and SSH traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  dynamic "ingress" {
    for_each = "var.sec-groups-ports"
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-server"
  }
}
