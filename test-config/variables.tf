variable "prefix" {
  type = string
  default = "dev"
}
variable "cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "subnet-cidr" {
  type = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}
variable "ingress_ports" {
  type = map(string)
  default = {
     22 = ["172.31.0.0/16"]
     80 = ["0.0.0.0/0"]
  }
}