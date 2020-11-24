resource "aws_s3_bucket" "test-bucket" {
  bucket = "project-devops-241120"
 # acl    = "private"
  policy = <<EOF
[{
  "Id": "Policy1606205384131",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1606205372733",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": ${aws_s3_bucket.test-bucket.arn},
      "Principal": "*"
    }
  ]
}]
EOF
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags = {
    Name        = "test-bucket"
    Environment = "Dev"
    Terraform = "yes"
  }
}