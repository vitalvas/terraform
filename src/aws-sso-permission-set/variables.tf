variable "instance_arn" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = null
}

variable "session_duration" {
  type    = string
  default = "PT12H"
}

variable "managed_policy_arns" {
  type    = list(string)
  default = []
}
