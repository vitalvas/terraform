resource "aws_iam_user" "main" {
  name          = "sa-${var.name}"
  path          = "/system/"
  force_destroy = var.force_destroy
}

resource "aws_iam_user_policy" "main" {
  name = "inline-policy"
  user = aws_iam_user.main.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = var.actions
        Resource = var.resources
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.allowed_ips
          }
        }
      },
    ]
  })
}
