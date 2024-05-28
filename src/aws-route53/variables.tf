variable "name" {
  type = string
}

variable "delegation_set_id" {
  type    = string
  default = ""
}

variable "records" {
  type = list(object({
    name    = string
    type    = string
    records = optional(list(string))
    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = optional(bool)
    }))
  }))

  default = [
    {
      name    = "dummy"
      type    = "TXT"
      records = ["dummy text"]
    }
  ]
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
