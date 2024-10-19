locals {
  name = var.fifo_queue == true ? "${var.name}.fifo" : var.name
}

resource "aws_sqs_queue" "main" {
  name = local.name

  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  fifo_queue                 = var.fifo_queue
}
