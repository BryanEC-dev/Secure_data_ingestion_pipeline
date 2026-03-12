variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "availability_zone_a" {
  description = "Availability zone for the first subnet"
  type        = string
}


variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}

variable "network_name" {
    description = "Name of the network"
    type = string
}

variable "subnet_private_cidr" {
  description = "CIDR block for the private subnet"
  type = string
}

variable "subnet-private-name" {
  description = "Name of the private subnet"
  type = string     
}

variable "route_table_private_name" {
  description = "Name of the route table for the private subnet"
  type = string     
}


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


variable "sqs_queue_name" {
  description = "The name of the SQS queue to be created"
  type = string
  
}

variable "terraform_user_arn" {
  description = "ARN del usuario IAM que ejecuta Terraform"
  type        = string
}