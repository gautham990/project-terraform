terraform {
  backend "s3" {
    bucket = "project-devops-backend"
    key    = "remote-backend.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "terraform-state-lock"
  }
}