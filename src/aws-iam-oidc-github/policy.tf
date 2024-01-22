data "aws_iam_policy_document" "github_role_policy_terraform" {
  statement {
    actions   = var.policy_actions
    resources = var.policy_resources
  }
}

resource "aws_iam_policy" "github_role" {
  name        = var.name
  path        = "/"
  description = "Policy for GitHub Actions for Terraform"
  policy      = data.aws_iam_policy_document.github_role_policy_terraform.json
}

resource "aws_iam_role_policy_attachment" "attach_github" {
  role       = aws_iam_role.github_role.name
  policy_arn = aws_iam_policy.github_role.arn
}

data "aws_iam_policy_document" "github_actions_assume_role_policy_terraform" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github_actions.arn,
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.token_sub
    }
  }
}

resource "aws_iam_role" "github_role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role_policy_terraform.json
}
