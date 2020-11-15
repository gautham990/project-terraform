locals {
  common_tags = {
    Name = "web-server"
    Environment = "PROD"
    Type = "frontend"
  }
}
resource "aws_instance" "web-server" {
  ami           = "ami-015a6758451df3cb9"
  instance_type = "t2.micro"
  tags = local.common_tags
  provisioner "local-exec" {
    when = "destroy"
    command = "echo ${aws_instance.web-server.private_ip} >> private_IP.txt"
  }
}