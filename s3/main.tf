resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.bucket-name
  acl    = "public-read"
  policy = <<EOF
{
  "Id": "Policy1606205384131",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1606205372733",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket-name}/*",
      "Principal": "*"
    }
  ]
}
EOF
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags = var.tags
}