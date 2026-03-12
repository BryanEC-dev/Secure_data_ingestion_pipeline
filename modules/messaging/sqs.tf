
resource "aws_sqs_queue" "dlp_dlq" {
  name = "${var.sqs_queue_name}-dlq"
}


# Política de la cola
data "aws_iam_policy_document" "dlp_queue_policy" {
  statement {
    sid    = "AllowS3SendMessage"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.dlp_queue.arn]
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [var.ingress_bucket_arn]  # ← viene de storage
    }
  }
}

resource "aws_sqs_queue" "dlp_queue" {
  name = var.sqs_queue_name

   redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlp_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue_policy" "dlp_queue_policy_attachment" {
  queue_url = aws_sqs_queue.dlp_queue.url
  policy    = data.aws_iam_policy_document.dlp_queue_policy.json
}

# Notificación S3 → SQS
resource "aws_s3_bucket_notification" "ingress_notification" {
  bucket = var.ingress_bucket_id  # ← viene de storage
  queue {
    queue_arn = aws_sqs_queue.dlp_queue.arn
    events    = ["s3:ObjectCreated:*"]
  }
}
