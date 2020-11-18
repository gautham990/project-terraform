output "web-server-public-ip" {
  value = aws_instance.web-server.public_ip
}
resource "aws_instance" "web-server-2" {
  ami = "ami-03faaf9cde2b38e9f"
  instance_type = "t2.micro"
  key_name = "main"
  security_groups = ["sg-0d2f2865f31ddca87"]
  subnet_id = "subnet-0ad9af17933c45e65"
  tags = {
    Name = "web-server2"
  }
}