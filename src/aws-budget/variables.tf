variable "account_id" {
  type = number
}

variable "budget_name" {
  type    = string
  default = "default"
}

variable "budget_type" {
  type    = string
  default = "COST"
}

variable "limit_amount" {
  type    = string
  default = "5.0"
}

variable "limit_unit" {
  type    = string
  default = "USD"
}

variable "subscriber_email_addresses" {
  type = list(string)
}

variable "threshold_actual" {
  type    = list(number)
  default = [90]
}

variable "threshold_forecasted" {
  type    = list(number)
  default = [90]
}

variable "cost_filters" {
  type    = map(list(string))
  default = {}
}
