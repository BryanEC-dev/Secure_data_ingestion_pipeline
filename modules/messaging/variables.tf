
variable "sqs_queue_name" {
  description = "The name of the SQS queue to be created"
  type = string
  
}

variable "ingress_bucket_arn" {
  description = "The ARN of the ingress S3 bucket"
  type = string
}

variable "ingress_bucket_id" {
  description = "The ID of the ingress S3 bucket"
  type = string
  
}