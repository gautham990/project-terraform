output "bucket-arn" {
  value = s3-module.aws_s3_bucket.s3-bucket.arn
}
output "bucket-endpoint" {
  value = aws_s3_bucket.s3-bucket.website_endpoint
}