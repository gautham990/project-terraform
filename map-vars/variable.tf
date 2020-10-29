variable "ami"{
  type = map
  default = {
    "ap-southeast-1" = "ami-02b6d9703a69265e9"
    "us-east-1" = "ami-0a782e324655d1cc0"
  }
}
variable "region" {
}
