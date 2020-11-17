variable "CIDR" {
  type = list(string)
  default = ["10.0.0.0/16"]
}
variable "VPC-name" {
  type = string
  default = "DEV-VPC"
}
variable "IG-name" {
  type = string
  default = "DEV-IG"
}
variable "subnet_CIDR" {
  type = list(data.aws_availability_zones.AZ.count)
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}
variable "subnet-name" {
  type = list(string)
  default = ["DEV-sub-1","DEV-sub-2","DEV-sub-3"]
}
variable "SG-name" {
  type = map
  default = {
    Name = "DEV-SG"
    Description = "This is default SG created with the module"
  }
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