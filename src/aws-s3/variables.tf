variable "bucket_name" {
  type    = string
  default = null
}

variable "bucket_prefix" {
  type    = string
  default = null
}

variable "versioning" {
  type    = bool
  default = false
}

variable "website" {
  type = object({
    index_document = string
    error_document = string
  })

  default = null
}

variable "acm_certificate_arn" {
  type    = string
  default = null
}

variable "lifecycle_rule" {
  type    = any
  default = []
}

variable "cloudfront" {
  type    = bool
  default = false
}

variable "cloudfront_aliases" {
  type    = list(string)
  default = []
}

variable "cloudfront_errors" {
  type    = map(string)
  default = {}
}

variable "cloudfront_viewer_protocol_policy" {
  type    = string
  default = "redirect-to-https"
}

variable "cloudfront_whitelist" {
  type    = list(string)
  default = []
}

variable "cloudfornt_default_ttl" {
  type     = number
  default  = 86400
  nullable = false
}

variable "cloudfront_max_ttl" {
  type     = number
  default  = 604800
  nullable = false
}

variable "cloudfront_blocked_countries" {
  type    = list(string)
  default = ["RU"]
}
