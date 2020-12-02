terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "project-devops"

    workspaces {
      name = "terraform-cloud-dev"
    }
  }
}