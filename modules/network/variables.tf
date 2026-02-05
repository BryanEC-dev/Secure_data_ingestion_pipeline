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
  description = "AWS region"
  type = string
}