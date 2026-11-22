data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  enable_logs     = var.cloudfront == true ? true : false
  lifecycle_rules = try(jsondecode(var.lifecycle_rule), var.lifecycle_rule)

  bucket_name = var.bucket_name != null && var.bucket_namespace == "account-regional" ? format("%s-%s-%s-an", var.bucket_name, data.aws_caller_identity.current.account_id, data.aws_region.current.region) : var.bucket_name

  cloudfront_geo_restriction_type      = length(var.cloudfront_whitelist) > 0 ? "whitelist" : "blacklist"
  cloudfront_geo_restriction_locations = length(var.cloudfront_whitelist) > 0 ? var.cloudfront_whitelist : var.cloudfront_blocked_countries
}
