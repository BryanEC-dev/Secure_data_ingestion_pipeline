output "ingress_bucket_arn" {
  value = aws_s3_bucket.ingress-bucket.arn
}

output "ingress_bucket_id" {
  value = aws_s3_bucket.ingress-bucket.id
}