terraform {
  required_version = ">= 1.5.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3" {
  source = "../../modules/s3"
  bucket_name = var.bucket_name
}

module "ec2" {
  source = "../../modules/ec2"
  project_name = var.project_name
  aws_region = var.aws_region
}