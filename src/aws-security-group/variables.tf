variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rules" {
  type    = list(any)
  default = []
}

variable "egress_rules" {
  type    = list(any)
  default = []
}
