locals {
  service_access = {
    default    = data.aws_iam_policy_document.topic_policy_default.json
    aws_backup = data.aws_iam_policy_document.topic_policy_aws_backup.json
  }

  topic_policy = local.service_access[var.service_access]
}

data "aws_iam_policy_document" "topic_policy_default" {
  statement {
    effect = "Allow"
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["arn:aws:sns:${var.region_name}:${var.account_id}:${var.name}"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values   = [var.account_id]
    }
  }
}

data "aws_iam_policy_document" "topic_policy_aws_backup" {
  statement {
    effect = "Allow"
    actions = [
      "SNS:Publish"
    ]
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
    resources = ["arn:aws:sns:${var.region_name}:${var.account_id}:${var.name}"]
  }
}
