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