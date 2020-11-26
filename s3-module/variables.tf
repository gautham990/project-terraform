variable "bucket-name" {
  description = "Unique name of the bucket"
  type = string
}
variable "tags" {
  description = "Tags for the bucket"
  type = map(string)
}