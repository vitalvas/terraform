resource "aws_s3_bucket_policy" "website" {
  count = var.website != null ? 1 : 0

  bucket = aws_s3_bucket.main.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject",
        Resource = [
          "${aws_s3_bucket.main.arn}/*",
        ]
        Condition = var.cloudfront == true ? {
          StringLike = {
            "aws:Referer" = local.private_key
          }
        } : null
      }
    ]
  })
}
