variable "name" {
  type = string
}

variable "encryption_enabled" {
  type    = bool
  default = true
}

variable "kms_master_key_id" {
  type    = string
  default = "alias/aws/sns"
}

variable "subscriptions" {
  type    = any
  default = []
}

variable "account_id" {
  type = string
}

variable "region_name" {
  type = string
}

variable "service_access" {
  type    = string
  default = "default"
}
