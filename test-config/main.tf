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
resource "aws_subnet" "subnet" {
  cidr_block = var.subnet-cidr[count.index]
  vpc_id = aws_vpc.VPC.id
  availability_zone = data.aws_availability_zones.AZ.names[count.index]
  tags = {
    Name = data.aws_availability_zones.AZ.names[count.index]
  }
  count = length(data.aws_availability_zones.AZ.names)
}


