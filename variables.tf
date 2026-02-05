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

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "aws_s3_ingress_bucket_name" {
  description = "nombre del bucket principal"
  type = string
}


variable "aws_s3_quarintine_bucket_name" {
  description = "nombre del bucket de cuarentena"
  type = string
}



variable "aws_s3_clean_bucket_name" {
  description = "nombre del bucket que contendra los archivos sin información sensible"
  type = string
}
