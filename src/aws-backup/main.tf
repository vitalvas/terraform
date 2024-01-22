resource "aws_backup_vault" "main" {
  name = "${var.aws_service}-${var.name}"
}

resource "aws_backup_vault_policy" "main" {
  backup_vault_name = aws_backup_vault.main.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Deny"
        Principal = "*"
        Resource  = "*"
        Action = [
          "backup:DeleteBackupVault",
          "backup:DeleteRecoveryPoint",
        ]
      }
    ]

  })

  depends_on = [
    aws_backup_vault.main
  ]
}

resource "aws_backup_plan" "main" {
  name = "${var.aws_service}-${var.name}"

  dynamic "rule" {
    for_each = local.backup_rules

    content {
      rule_name         = lookup(rule.value, "rule_name", rule.key)
      target_vault_name = aws_backup_vault.main.name
      schedule          = lookup(rule.value, "schedule", null)

      start_window             = lookup(rule.value, "start_window", null)
      completion_window        = lookup(rule.value, "completion_window", null)
      enable_continuous_backup = lookup(rule.value, "enable_continuous_backup", false)

      dynamic "lifecycle" {
        for_each = lookup(rule.value, "lifecycle", null) != null ? [true] : []

        content {
          cold_storage_after = lookup(rule.value.lifecycle, "cold_storage_after", null)
          delete_after       = lookup(rule.value.lifecycle, "delete_after", null)
        }
      }
    }
  }

  depends_on = [
    aws_backup_vault.main
  ]
}

resource "aws_backup_selection" "main" {
  count = length(var.resources) > 0 ? 1 : 0

  name         = "${var.aws_service}-${var.name}"
  plan_id      = aws_backup_plan.main.id
  iam_role_arn = aws_iam_role.main.arn

  resources = var.resources

  depends_on = [
    aws_backup_plan.main,
    aws_iam_role.main
  ]
}
