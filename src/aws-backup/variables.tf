variable "aws_service" {
  type = string
}

variable "name" {
  type = string
}

variable "resources" {
  type    = list(string)
  default = []
}

variable "sns_topic_arn" {
  type    = string
  default = ""
}

variable "backup_vault_events" {
  type = list(string)
  default = [
    "BACKUP_JOB_EXPIRED",
    "RECOVERY_POINT_MODIFIED",
    "BACKUP_PLAN_MODIFIED",
    "BACKUP_JOB_FAILED",
    "RESTORE_JOB_FAILED",
    "COPY_JOB_FAILED",
    "S3_BACKUP_OBJECT_FAILED",
    "S3_RESTORE_OBJECT_FAILED",
    "RESTORE_JOB_COMPLETED",
  ]
}
