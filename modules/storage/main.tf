


resource "aws_s3_bucket" "ingress-bucket" {
  bucket = var.aws_s3_ingress_bucket_name

  tags = {
    Name        =  var.aws_s3_ingress_bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "block_ingress-bucket" {
  bucket = aws_s3_bucket.ingress-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
}

resource "aws_s3_bucket_versioning" "versioning_ingress-bucket" {
  bucket = aws_s3_bucket.ingress-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ingress_bucket_encryption" {
  bucket = aws_s3_bucket.ingress-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms" //TODO: Cambiar a AWS KMS para una mejor seguridad
    }
  }
}
/* 
data "aws_iam_policy_document" "ingress_bucket_policy" {
  

  statement {
    sid       = "DenyOutsideVPCToIngressBucket"
    effect    = "Deny"
    actions   = ["s3:*"]
    resources = [
      aws_s3_bucket.ingress-bucket.arn,
      "${aws_s3_bucket.ingress-bucket.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"
      values   = [var.vpc_id]
    }

    condition {
      test = "StringNotEquals"
      variable = "aws:PrincipalArn"
      values = [var.terraform_user_arn]
    }
  }

    # Regla 2: Denegar cualquier transferencia sin encriptación
  statement {
    sid       = "DenyNonEncryptedToIngressBucket"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.ingress-bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["aws:kms"]
    }
  } 

}

resource "aws_s3_bucket_policy" "ingress_bucket_policy" {
  bucket = aws_s3_bucket.ingress-bucket.id
  policy = data.aws_iam_policy_document.ingress_bucket_policy.json
} 
 */



#otroos buckets

resource "aws_s3_bucket" "clean-bucket" {
  bucket = var.aws_s3_clean_bucket_name

  tags = {
    Name        = var.aws_s3_clean_bucket_name
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
       sse_algorithm     = "aws:kms" 
    }
  }
}


data "aws_iam_policy_document" "clean_bucket_policy" {
  
  statement {
    sid       = "DenyOutsideVPCToCleanBucket"
    effect    = "Deny"
    actions   = ["s3:*"]
    resources = [
      aws_s3_bucket.clean-bucket.arn,
      "${aws_s3_bucket.clean-bucket.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"
      values   = [var.vpc_id]
    }

    condition {
      test = "StringNotEquals"
      variable = "aws:PrincipalArn"
      values = [var.terraform_user_arn]
    }
  }

    # Regla 2: Denegar cualquier transferencia sin encriptación
  statement {
    sid       = "DenyNonEncryptedToCleanBucket"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.clean-bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["aws:kms"]
    }
  } 

}

resource "aws_s3_bucket_policy" "clean_bucket_policy" {
  bucket = aws_s3_bucket.clean-bucket.id
  policy = data.aws_iam_policy_document.clean_bucket_policy.json
} 



resource "aws_s3_bucket" "quarantine-bucket" {
  bucket = var.aws_s3_quarantine_bucket_name
  object_lock_enabled = true

  tags = {
    Name        = var.aws_s3_quarantine_bucket_name
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
       sse_algorithm     = "aws:kms" 
    }
  }
}

data "aws_iam_policy_document" "quarantine_bucket_policy" {


 
  statement {
    sid       = "DenyOutsideVPCToQuarantineBucket"
    effect    = "Deny"
    actions   = ["s3:*"]
    resources = [
      aws_s3_bucket.quarantine-bucket.arn,
      "${aws_s3_bucket.quarantine-bucket.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"
      values   = [var.vpc_id]
    }

    condition {
      test = "StringNotEquals"
      variable = "aws:PrincipalArn"
      values = [var.terraform_user_arn]
    }
  }

    # Regla 2: Denegar cualquier transferencia sin encriptación
  statement {
    sid       = "DenyNonEncryptedToQuarantineBucket"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.quarantine-bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["aws:kms"]
    }
  } 

}

resource "aws_s3_bucket_policy" "quarantine_bucket_policy" {
  bucket = aws_s3_bucket.quarantine-bucket.id
  policy = data.aws_iam_policy_document.quarantine_bucket_policy.json
} 

resource "aws_s3_bucket_object_lock_configuration" "quarantine_bucket_object_lock" {
  bucket = aws_s3_bucket.quarantine-bucket.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 3
    }
  }
}


