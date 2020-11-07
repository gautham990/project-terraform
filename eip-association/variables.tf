variable "cidr" {
  default = {
    "ap-southeast-1a" = "10.0.1.0/24"
    "ap-southeast-1b" = "10.0.2.0/24"
    "ap-southeast-1c" = "10.0.3.0/24"
  }
}
variable "az" {
  default = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}
variable "sec-groups-ports" {
  description = "Allowed ports"
  type        = map
  default     = {
    "443" = ["0.0.0.0/0"]
    "22"  = ["0.0.0.0/0"]
    "80"  = ["0.0.0.0/0"]
  }
}