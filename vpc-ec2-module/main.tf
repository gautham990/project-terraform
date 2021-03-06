module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"
  name = var.name
  cidr = var.cidr
  azs = var.azs
  public_subnets = var.public_subnets
  tags = {
    terraform = "true"
    env = "dev"
    Name = "dev-vpc"
  }
}
resource "aws_security_group" "web-server" {
  name        = "allow ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "web-server"

  ami                    = "ami-03faaf9cde2b38e9f"
  instance_type          = "t2.micro"
  key_name               = "main"
  vpc_security_group_ids = [aws_security_group.web-server.id]
  subnet_id              = module.vpc.public_subnets[count.index]
  count                  = 2

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
