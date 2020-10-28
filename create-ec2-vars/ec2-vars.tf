#EC2 resource
resource "aws_instance" "terraform-ec2-vars" {
  ami = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-ec2-vars"
  }
}
