variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rule" {
  type = list(any)
}

variable "egress_rule" {
  type = list(any)
}
