#EC2 resource
resource "aws_instance" "terraform-ec2" {
  ami = "ami-015a6758451df3cb9"
  instance_type = "t2.micro"
}