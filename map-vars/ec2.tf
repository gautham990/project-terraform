resource "aws_instance" "ec2-vars" {
  ami = "var.ami[var.region]"
  instance_type = "t2.micro"
}