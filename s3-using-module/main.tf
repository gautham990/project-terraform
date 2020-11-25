module "s3-module" {
  source = "../s3-module"
  bucket-name = "project-devops-251120"
  tags = {
    env = "dev"
    terraform = "yes"
  }
}