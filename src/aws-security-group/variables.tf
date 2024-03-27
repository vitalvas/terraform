variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rule" {
  type = any
}

variable "egress_rule" {
  type = any
}
