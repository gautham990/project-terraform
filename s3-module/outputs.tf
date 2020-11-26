output "bucket-arn" {
  description = "ARN of the bucket"
  value = aws_s3_bucket.s3-bucket.arn
}
output "bucket-endpoint" {
  description = "Website endpoint"
  value = aws_s3_bucket.s3-bucket.website_endpoint
}