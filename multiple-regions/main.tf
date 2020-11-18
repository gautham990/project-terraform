
data "aws_ami" "AMI-web1" {
  owners = ["137112412989"]
  most_recent = "true"
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "web1" {
  ami           = data.aws_ami.AMI-web1.id
  instance_type = "t2.micro"
  key_name = "main"
  tags = {
    Name = lookup(var.EC2-name,"ap-southeast-1" )
  }
}
data "aws_ami" "AMI-web2" {
  provider = aws.mumbai
  owners = ["137112412989"]
  most_recent = "true"
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "web2" {
  provider = aws.mumbai
  ami           = data.aws_ami.AMI-web2.id
  instance_type = "t2.micro"
  tags = {
    Name = lookup(var.EC2-name,"ap-south-1" )
  }
}