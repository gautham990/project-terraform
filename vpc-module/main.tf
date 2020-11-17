resource "aws_vpc" "vpc" {
  cidr_block       = var.CIDR
  instance_tenancy = "default"
  tags = {
    Name = var.VPC-name
  }
}
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.IG-name
  }
}
data "aws_availability_zones" "AZ" {
  all_availability_zones = true
}
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.AZ.names[count.index]
  cidr_block = var.subnet_CIDR[count.index]
  tags = {
    Name = var.subnet-name[count.index]
  }
  count = length(data.aws_availability_zones.AZ.names)
}
resource "aws_route" "main-RT" {
  route_table_id = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IG.id
}
resource "aws_route_table_association" "rt-association" {
  route_table_id = aws_vpc.vpc.main_route_table_id
  subnet_id      = aws_subnet.subnet[count.index].id
  count = length(data.aws_availability_zones.AZ.names)
}
resource "aws_security_group" "SG" {
  name        = lookup(var.SG-name,"Name" )
  description = lookup(var.SG-name,"Description" )
  vpc_id      = aws_vpc.vpc.id
  dynamic "ingress" {
    for_each = var.sec-groups-ports
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = lookup(var.SG-name,"Name")
  }
}