output "publicIP" {
  value = aws_instance.*.public_ip
}