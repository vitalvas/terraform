resource "aws_s3_bucket_policy" "cloudfront" {
  count = var.cloudfront == true ? 1 : 0

  bucket = aws_s3_bucket.main.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject",
        Resource = [
          "${aws_s3_bucket.main.arn}/*",
        ]
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.main[0].arn
          }
        }
      },
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject",
        Resource = [
          "${aws_s3_bucket.main.arn}/*",
        ]
        Condition = {
          StringLike = {
            "aws:Referer" = local.private_key
          }
        }
      }
    ]
  })
}
