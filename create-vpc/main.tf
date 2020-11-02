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
  cidr_block = var.cidr[aws_subnet.prod-subnet.availability_zone]
  tags = {
    Name = var.az[count.index]
  }
  count = 3
}
/*
resource "aws_route_table" "prod-rt" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-IG.id
  }
}
*/