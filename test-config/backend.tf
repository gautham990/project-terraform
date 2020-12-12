terraform {
  backend "s3" {
    bucket = "project-devops-backend"
    key    = "terraform.tfstate"
    region =  "ap-southeast-1"
  }
}