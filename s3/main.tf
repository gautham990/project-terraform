resource "aws_s3_bucket" "test-bucket" {
  bucket = "project-devops-241120"
 # acl    = "private"

  tags = {
    Name        = "test-bucket"
    Environment = "Dev"
    Terraform = "yes"
  }
}