variable "name" {
  type = string
}

variable "tag_immutable" {
  type    = bool
  default = true
}

variable "force_delete" {
  type    = bool
  default = false
}

variable "scan_on_push" {
  type    = bool
  default = false
}
