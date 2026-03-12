variable "aws_s3_ingress_bucket_name" {
  description = "nombre del bucket principal"
  type = string
}


variable "aws_s3_quarantine_bucket_name" {
  description = "nombre del bucket de cuarentena"
  type = string
}



variable "aws_s3_clean_bucket_name" {
  description = "nombre del bucket que contendra los archivos sin información sensible"
  type = string
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string  
}

variable "vpc_id" {
  description = "ID of the VPC where the S3 buckets will be created"
  type        = string
}

variable "terraform_user_arn" {
  description = "ARN del usuario IAM que ejecuta Terraform"
  type        = string
}

