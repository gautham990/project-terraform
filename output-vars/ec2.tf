resource "aws_instance" "terraform" {
  ami = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "terraform"
  }
}
output "public-ip" {
  value = aws_instance.terraform.public_ip
}