# crear vpc 
resource "aws_vpc" "vpc_proyect_information" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true   # ← agregar
  enable_dns_hostnames = true   # ← agregar
  tags = {
    Name = var.network_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_proyect_information.id
  cidr_block        = var.subnet_private_cidr
  availability_zone = var.availability_zone_a
  tags = {
    Name = var.subnet-private-name
  }
  
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc_proyect_information.id
  tags = {
    Name = var.route_table_private_name
  }
}

resource "aws_route_table_association" "aws_route_table_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id

}




resource "aws_security_group" "dlp_security_group" {
  name        = "permissions_security_group"
  description = "Security group for DLP project"
  vpc_id      = aws_vpc.vpc_proyect_information.id

 tags = {
    Name = "dlp_security_group"
  }

    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "HTTPS to VPC endpoints"
    }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "HTTPS from VPC resources"
    }
    
}



data "aws_iam_policy_document" "s3_endpoint_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:ListBucket"]
    resources = [
      "arn:aws:s3:::${var.aws_s3_ingress_bucket_name}",
      "arn:aws:s3:::${var.aws_s3_ingress_bucket_name}/*",
      "arn:aws:s3:::${var.aws_s3_clean_bucket_name}",
      "arn:aws:s3:::${var.aws_s3_clean_bucket_name}/*",
      "arn:aws:s3:::${var.aws_s3_quarantine_bucket_name}",
      "arn:aws:s3:::${var.aws_s3_quarantine_bucket_name}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceVpc"
      values   = [aws_vpc.vpc_proyect_information.id]
    }
  }
}



resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.vpc_proyect_information.id
  service_name      = "com.amazonaws.${var.region}.s3"
  route_table_ids   = [aws_route_table.private_route_table.id]
  policy          = data.aws_iam_policy_document.s3_endpoint_policy.json
  tags = {
    Name = "s3-endpoint"
  }
}




locals {
  interface_endpoints = toset([
    "sqs",
    "sns",
    "comprehend",
    "macie2",
    "logs",
    "events",
    "lambda"
  ])
}

data "aws_iam_policy_document" "interface_endpoint_policy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceVpc"
      values   = [aws_vpc.vpc_proyect_information.id]
    }
  }
}


resource "aws_vpc_endpoint" "interface_endpoints" {
  for_each = local.interface_endpoints

  vpc_id              = aws_vpc.vpc_proyect_information.id
  service_name        = "com.amazonaws.${var.region}.${each.key}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_subnet.id]
  security_group_ids  = [aws_security_group.dlp_security_group.id]
  private_dns_enabled = true
   policy              = data.aws_iam_policy_document.interface_endpoint_policy.json

  tags = {
    Name = "dlp-endpoint-${each.key}"
  }
}