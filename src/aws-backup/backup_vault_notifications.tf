# Vault Notification Events
# https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-notifications.html

resource "aws_backup_vault_notifications" "main" {
  count = length(var.sns_topic_arn) > 0 ? 1 : 0

  backup_vault_name = aws_backup_vault.main.name
  sns_topic_arn     = var.sns_topic_arn

  backup_vault_events = var.backup_vault_events

  depends_on = [
    aws_backup_vault.main
  ]
}
