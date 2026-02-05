provider "aws" {
  region = "us-east-1" 
}

# Bucket para guardar el archivo .tfstate
resource "aws_s3_bucket" "terraform_state" {
  bucket = "proyects-terraform-bs-ec" 
  
  lifecycle {
    prevent_destroy = true # Protege el bucket de borrados accidentales
  }
}

# Habilitar versionado
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
