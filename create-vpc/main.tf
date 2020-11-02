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

variable "az-names" {
  type = list
  default = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}
variable "subnet-cidr" {
  type = list
  default = ["10.0.0.0","10.0.1.0","10.0.2.0"]
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
  cidr_block = var.subnet-cidr[count.index]/24
  availability_zone = "var.az-names[count.index]"

  tags = {
    Name = "var.az-names[count.index]"
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