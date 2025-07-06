variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "instance_type" {
  description = "EC2インスタンスタイプ（無料枠: t2.micro）" 
  type        = string
  default     = "t3.micro"
}

variable "user_data" {
    description = "EC2インスタンス起動時に実行するスクリプト"
    type = string
    default = ""
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}