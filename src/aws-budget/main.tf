resource "aws_budgets_budget" "main" {
  account_id        = var.account_id
  name              = var.budget_name
  budget_type       = var.budget_type
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2017-07-01_00:00"
  time_unit         = "MONTHLY"

  dynamic "notification" {
    for_each = var.threshold_actual

    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = var.subscriber_email_addresses
    }
  }

  dynamic "notification" {
    for_each = var.threshold_forecasted

    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value
      threshold_type             = "PERCENTAGE"
      notification_type          = "FORECASTED"
      subscriber_email_addresses = var.subscriber_email_addresses
    }
  }

  dynamic "cost_filter" {
    for_each = var.cost_filters

    content {
      name   = cost_filter.key
      values = cost_filter.value
    }
  }
}
