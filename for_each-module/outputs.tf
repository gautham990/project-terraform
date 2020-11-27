output "bucket-arn-dev" {
  value = module.s3-module[dev].bucket-arn
}
output "bucket-arn-prod" {
  value = module.s3-module[prod].bucket-arn
}
output "bucket-endpoint-dev" {
  value = module.s3-module[dev].bucket-endpoint
}
output "bucket-endpoint-prod" {
  value = module.s3-module[prod].bucket-endpoint
}