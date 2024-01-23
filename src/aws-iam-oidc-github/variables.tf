variable "name" {
  type    = string
  default = "github-actions-terraform"
}

variable "policy_actions" {
  type = list(string)
  default = [
    "acm:*",
    "backup-storage:*",
    "backup:*",
    "budgets:*",
    "cloudformation:*",
    "cloudfront:*",
    "iam:*",
    "kms:*",
    "logs:*",
    "organizations:*",
    "s3:*",
    "sns:*",
    "sqs:*",
    "sso:*",
  ]
}

variable "policy_resources" {
  type    = list(string)
  default = ["*"]
}

variable "token_sub" {
  type = list(string)
}
