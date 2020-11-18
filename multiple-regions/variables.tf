variable "EC2-name" {
  type = map(string)
  default = {
    "ap-south-1" = "web-mumbai"
    "ap-southeast-1" = "web-sg"
  }
}