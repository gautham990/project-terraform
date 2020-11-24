variable "name" {
  type = string
  default = "dev-vpc"
}
variable "cidr" {
  type  = string
  default = ["10.0.0.0/16"]
}
variable "azs" {
  type = list
  default = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}
variable "public_subnets" {
  type = list
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}