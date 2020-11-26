module "s3-module" {
  source = "app.terraform.io/project-devops/s3-website/aws"
  version = "1.0.0"
  bucket-name = "project-devops-251120"
  tags = {
    env = "dev"
    terraform = "yes"
  }
}

