data "aws_caller_identity" "current" {}

locals {
  repo_name_1 = replace(var.repo_name, "/", "-")
  repo_name   = replace(local.repo_name_1, ".", "-")

  role_name = length(var.role_name) > 0 ? var.role_name : "github-actions-${local.repo_name}"

  token_sub = length(var.token_sub) > 0 ? var.token_sub : ["repo:${var.repo_name}:ref:refs/heads/*"]

  trust_policy_principal = length(var.trust_policy_principal) > 0 ? var.trust_policy_principal : [
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
  ]

  inline_policy_statement = [
    for policy in var.data : {
      Effect   = "Allow"
      Action   = policy.actions
      Resource = policy.resources
    }
  ]
}

data "aws_iam_policy_document" "github_actions_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = local.trust_policy_principal
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.token_sub
    }
  }
}

resource "aws_iam_role" "github_role" {
  name = local.role_name

  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role_policy.json

  dynamic "inline_policy" {
    for_each = length(local.inline_policy_statement) > 0 ? [1] : []

    content {
      name = "inline-policy"

      policy = jsonencode({
        Version   = "2012-10-17"
        Statement = local.inline_policy_statement
      })
    }
  }
}
