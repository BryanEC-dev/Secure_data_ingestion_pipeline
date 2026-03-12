terraform {
  backend "s3" {
    # Nombre del bucket que creaste en el paso anterior
    bucket         = "proyects-terraform-bs-ec"
    key            = "proyect/cloud-practitioner/data-ingestion/terraform.tfstate"
    region         = "us-east-1"

    
    use_lockfile = true
    encrypt        = true
  }

  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
    }
  } 
}



# Configurar el proveedor de AWS
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "SecureDataIngestion"
      Environment = "Dev"
      Owner       = "Bryan"
      ManagedBy   = "Terraform"
    }
  }
  
}

# Módulo de red

module "network" {

source = "./modules/network"
region = var.region
availability_zone_a = var.availability_zone_a

network_name        = var.network_name
vpc_cidr            = var.vpc_cidr
subnet_private_cidr = var.subnet_private_cidr
subnet-private-name = var.subnet-private-name
route_table_private_name = var.route_table_private_name

aws_s3_ingress_bucket_name   = var.aws_s3_ingress_bucket_name
aws_s3_clean_bucket_name     = var.aws_s3_clean_bucket_name
aws_s3_quarantine_bucket_name = var.aws_s3_quarantine_bucket_name

}


module "storage" {
  source = "./modules/storage"
  vpc_id                       = module.network.vpc_id_final
  aws_s3_ingress_bucket_name   = var.aws_s3_ingress_bucket_name
  aws_s3_quarantine_bucket_name = var.aws_s3_quarantine_bucket_name
  aws_s3_clean_bucket_name     = var.aws_s3_clean_bucket_name
  region                       = var.region
  
  terraform_user_arn = var.terraform_user_arn

} 


module "sqs_queue" {
  source = "./modules/messaging"

  sqs_queue_name = var.sqs_queue_name
  ingress_bucket_arn = module.storage.ingress_bucket_arn
  ingress_bucket_id  = module.storage.ingress_bucket_id

}
