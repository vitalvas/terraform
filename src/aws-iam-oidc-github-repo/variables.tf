variable "role_name" {
  type    = string
  default = ""
}

variable "trust_policy_principal" {
  type    = list(string)
  default = []
}

variable "repo_name" {
  type = string
}

variable "token_sub" {
  type    = list(string)
  default = []
}

variable "data" {
  type = list(object({
    resources = list(string)
    actions   = list(string)
  }))
}
