variable "name" {
  type = string
}

variable "about_text" {
  type    = string
  default = null
}

variable "architectures" {
  type    = list(string)
  default = []
}

variable "description" {
  type    = string
  default = null
}

variable "logo_image_blob" {
  type    = string
  default = null
}

variable "operating_systems" {
  type    = list(string)
  default = ["Linux"]
}

variable "usage_text" {
  type    = string
  default = null
}
