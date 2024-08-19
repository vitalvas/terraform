locals {

  policy_cloudfront_statement = length(aws_cloudfront_distribution.main) > 0 ? {
    Effect = "Allow"
    Principal = {
      Service = "cloudfront.amazonaws.com"
    }
    Action = "s3:GetObject"
    Resource = [
      "${aws_s3_bucket.main.arn}/*",
    ]
    Condition = {
      StringEquals = {
        "AWS:SourceArn" = aws_cloudfront_distribution.main[0].arn
      }
    }
  } : null

  policy_referer_statement = {
    Effect    = "Allow"
    Principal = "*"
    Action    = "s3:GetObject"
    Resource = [
      "${aws_s3_bucket.main.arn}/*",
    ]
    Condition = {
      StringLike = {
        "aws:Referer" = local.private_key
      }
    }
  }

  policy_ses_statement = {
    Effect = "Allow"
    Principal = {
      Service = "ses.amazonaws.com"
    }
    Action = "s3:PutObject"
    Resource = [
      "${aws_s3_bucket.main.arn}/*",
    ]
    Condition = {
      StringEquals = {
        "aws:Referer" = data.aws_caller_identity.current.account_id
      }
    }
  }


  bucket_policy_statements = concat(
    var.cloudfront == true ? [local.policy_cloudfront_statement, local.policy_referer_statement] : null,
    var.policy_enable_ses == true ? [local.policy_ses_statement] : null,
  )
}

resource "aws_s3_bucket_policy" "main" {
  count = length(local.bucket_policy_statements) > 0 ? 1 : 0

  bucket = aws_s3_bucket.main.id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.bucket_policy_statements
  })
}
