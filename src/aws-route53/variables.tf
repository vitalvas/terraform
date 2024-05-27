variable "name" {
  type = string
}

variable "delegation_set_id" {
  type    = string
  default = ""
}

variable "records" {
  type    = list(any)
  default = null
}

variable "record_default_ttl" {
  type    = number
  default = 1800
}

variable "record_allow_overwrite" {
  type    = bool
  default = false
}
