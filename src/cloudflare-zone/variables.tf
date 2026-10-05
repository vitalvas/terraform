variable "account_id" {
  type = string
}

variable "name" {
  type = string
}

variable "plan" {
  type    = string
  default = "free"
}

variable "paused" {
  type    = bool
  default = false
}

variable "type" {
  type    = string
  default = "full"
}

variable "dnssec" {
  type    = bool
  default = false
}

variable "records" {
  type    = list(any)
  default = null
}
