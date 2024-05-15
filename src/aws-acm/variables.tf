variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "validation_method" {
  type    = string
  default = "DNS"
}

variable "key_algorithm" {
  type    = string
  default = "RSA_2048"
}
