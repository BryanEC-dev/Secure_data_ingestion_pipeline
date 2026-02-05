

resource "aws_s3_bucket" "clean-bucket" {
  bucket = "clean-bucket-clinica-ec"

  tags = {
    Name        = "clean-bucket-clinica-ec"
  }
}


resource "aws_s3_bucket_public_access_block" "block_clean-bucket" {
  bucket = aws_s3_bucket.clean-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
}



resource "aws_s3_bucket_versioning" "versioning_clean-bucket" {
  bucket = aws_s3_bucket.clean-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "clean_bucket_encryption" {
  bucket = aws_s3_bucket.clean-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256" 
    }
  }
}


resource "aws_s3_bucket" "quarantine-bucket" {
  bucket = "quarantine-bucket-clinica-ec"

  tags = {
    Name        = "quarantine-bucket-clinica-ec"
  }
}


resource "aws_s3_bucket_public_access_block" "block_quarantine-bucket" {
  bucket = aws_s3_bucket.quarantine-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
}

resource "aws_s3_bucket_versioning" "versioning_quarantine-bucket" {
  bucket = aws_s3_bucket.quarantine-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "quarantine_bucket_encryption" {
  bucket = aws_s3_bucket.quarantine-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256" 
    }
  }
}




resource "aws_s3_bucket" "landing-bucket" {
  bucket = "landing-bucket-clinica-ec"

  tags = {
    Name        = "landing-bucket-clinica-ec"
  }
}

resource "aws_s3_bucket_public_access_block" "block_landing-bucket" {
  bucket = aws_s3_bucket.landing-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
}

resource "aws_s3_bucket_versioning" "versioning_landing-bucket" {
  bucket = aws_s3_bucket.landing-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "landing_bucket_encryption" {
  bucket = aws_s3_bucket.landing-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256" 
    }
  }
}
