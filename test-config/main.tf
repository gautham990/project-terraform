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
resource "aws_route" "RT" {
  route_table_id = aws_vpc.VPC.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IG.id
}
resource "aws_route_table_association" "rt-association" {
  route_table_id = aws_vpc.VPC.main_route_table_id
  subnet_id      = aws_subnet.subnet[count.index].id
  count = length(data.aws_availability_zones.AZ.names)
}

