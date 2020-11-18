output "private-IP1" {
  value = aws_instance.web1.private_ip
}
output "private-IP2" {
  value = aws_instance.web2.private_ip
}