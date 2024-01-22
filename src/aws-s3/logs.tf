resource "aws_s3_bucket" "logs" {
  count = local.enable_logs == true ? 1 : 0

  bucket        = "${var.bucket_name}-awslogs"
  force_destroy = true

  tags = {
    type = "awslogs"
  }
}

resource "aws_s3_bucket_ownership_controls" "logs" {
  count = local.enable_logs == true ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id

  rule {
    object_ownership = "ObjectWriter"
  }

  depends_on = [
    aws_s3_bucket.logs
  ]
}

resource "aws_s3_bucket_policy" "logs" {
  count = local.enable_logs == true ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSLogDeliveryWrite"
        Effect = "Allow"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
        Resource = ["${aws_s3_bucket.logs[0].arn}/*"]
        Action   = "s3:PutObject"
      },
      {
        Sid    = "AWSLogDeliveryCheck"
        Effect = "Allow"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
        Resource = [aws_s3_bucket.logs[0].arn]
        Action = [
          "s3:GetBucketAcl",
          "s3:ListBucket",
        ]
      },
      {
        Sid    = "S3ServerAccessLogsPolicy"
        Effect = "Allow"
        Principal = {
          Service = "logging.s3.amazonaws.com"
        }
        Resource = ["${aws_s3_bucket.logs[0].arn}/s3/*"]
        Action   = "s3:PutObject"
      }
    ]
  })
  depends_on = [
    aws_s3_bucket.logs,
    aws_s3_bucket_ownership_controls.logs,
  ]
}

resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  count = local.enable_logs == true ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id

  rule {
    id     = "default"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 180
      storage_class = "GLACIER"
    }

    expiration {
      days = 1096
    }

    noncurrent_version_expiration {
      noncurrent_days = 7
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_logging" "main" {
  count = local.enable_logs == true ? 1 : 0

  bucket        = aws_s3_bucket.main.id
  target_bucket = aws_s3_bucket.logs[0].id
  target_prefix = "s3/"

  depends_on = [
    aws_s3_bucket.main,
    aws_s3_bucket.logs,
    aws_s3_bucket_ownership_controls.logs,
    aws_s3_bucket_policy.logs,
  ]
}
