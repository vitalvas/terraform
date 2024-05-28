variable "name" {
  type = string
}

variable "delegation_set_id" {
  type    = string
  default = ""
}

variable "records" {
  type    = list(any)
  default = []
}

variable "record_default_ttl" {
  type    = number
  default = 1800
}

variable "record_allow_overwrite" {
  type    = bool
  default = false
}

variable "dnssec_enabled" {
  type    = bool
  default = false
}

variable "dnssec_kms_keys" {
  type = list(object({
    name     = optional(string, "main")
    key_arn  = string
    inactive = optional(bool, false)
  }))

  default = []
}
