variable "name" {
  type = string
}

variable "allowed_ips" {
  type    = list(string)
  default = ["127.0.0.1/32"]
}

variable "actions" {
  type = list(string)
  default = [
    "s3:ListBucket",
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject",
    "s3:GetBucketLocation",
  ]
}

variable "resources" {
  type = list(string)
  default = [
    "arn:aws:s3:::vv-dummy"
  ]
}
