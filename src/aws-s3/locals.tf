data "aws_caller_identity" "current" {}

locals {
  enable_logs     = var.cloudfront == true ? true : false
  lifecycle_rules = try(jsondecode(var.lifecycle_rule), var.lifecycle_rule)

  cloudfront_geo_restriction_type      = length(var.cloudfront_whitelist) > 0 ? "whitelist" : "blacklist"
  cloudfront_geo_restriction_locations = length(var.cloudfront_whitelist) > 0 ? var.cloudfront_whitelist : var.cloudfront_blocked_countries
}
