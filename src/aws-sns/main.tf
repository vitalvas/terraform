resource "aws_sns_topic" "main" {
  name              = var.name
  kms_master_key_id = var.encryption_enabled == true ? var.kms_master_key_id : null

  policy = local.topic_policy
}

resource "aws_sns_topic_subscription" "main" {
  for_each = {
    for sub in var.subscriptions : md5(jsonencode(sub)) => sub
  }

  topic_arn = aws_sns_topic.main.arn

  protocol = try(each.value.protocol, null)
  endpoint = try(each.value.endpoint, null)
}
