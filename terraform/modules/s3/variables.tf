variable "bucket_name" {
  description = "S3バケット名"
  type        = string
}

variable "versioning_enabled" {
  description = "バージョニングを有効にするか"
  type        = bool
  default     = false
}

variable "tags" {
  description = "リソースタグ"
  type        = map(string)
  default     = {}
}