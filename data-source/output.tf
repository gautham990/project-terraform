output "AMI_ID" {
  value = data.aws_ami.web
}

output "web-server-public-ip" {
  value = aws_instance.web-server.public_ip
}