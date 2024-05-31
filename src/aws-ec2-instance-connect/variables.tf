variable "name" {
  type    = string
  default = "main"
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type    = list(string)
  default = null
}

variable "preserve_client_ip" {
  type    = bool
  default = true
}
