module "s3-module" {
  for_each = toset(["dev","prod"])
  source = "app.terraform.io/project-devops/s3-website/aws"
  version = "1.0.0"
  bucket-name = "project-devops-${each.key}"
  tags = {
    env = each.key
    terraform = "yes"
  }
}

