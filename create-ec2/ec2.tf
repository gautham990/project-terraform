#Provider block
provider "aws" {
  region = "ap-southeast-1"
}
#EC2 resource
resource "aws_instance" "" {
  ami = "ami-015a6758451df3cb9"
  instance_type = "t2.micro"
}