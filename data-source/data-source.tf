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
resource "aws_security_group" "web-server-sg" {
  name        = "web-server-sg"
  description = "Allows web and SSH traffic"
  vpc_id      = aws_vpc.prod-vpc.id
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
    Name = "web-server-sg"
  }
}
data "aws_ami" "web" {
  owners = ["099720109477"]
  most_recent = "true"
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name = "virtualization_type"
    values = ["hvm"]
  }
}
resource "aws_instance" "web-server" {
  ami           = data.aws_ami.web.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.prod-subnet[0].id
  vpc_security_group_ids = [aws_security_group.web-server-sg.id]
  associate_public_ip_address = true
  key_name = "main"
  tags = local.common_tags
}

