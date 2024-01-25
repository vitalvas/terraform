resource "aws_ssoadmin_permission_set" "main" {
  instance_arn = var.instance_arn

  name             = var.name
  description      = var.description
  session_duration = var.session_duration
}

resource "aws_ssoadmin_managed_policy_attachment" "main" {
  for_each = {
    for managed_policy_arn in var.managed_policy_arns : md5(managed_policy_arn) => managed_policy_arn
  }

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.main.arn
  managed_policy_arn = each.value
}
