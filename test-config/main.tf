resource "aws_vpc" "VPC" {
  cidr_block = var.cidr
  instance_tenancy = "default"
  tags = {
    Name = "VPC-${var.prefix}"
  }
}
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "IG-${var.prefix}"
  }
}
data "aws_availability_zones" "AZ" {
  all_availability_zones = true
}

