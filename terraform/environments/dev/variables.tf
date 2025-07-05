variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "sample-bucket-hasutosasaki"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "sample-project"
}