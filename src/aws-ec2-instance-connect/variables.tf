variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type    = list(string)
  default = null
}

variable "preserve_client_ip" {
  type    = bool
  default = true
}
