locals {
  viewer_certificate = {
    cloudfront_default_certificate = true
  }

  viewer_certificate_acm = {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  private_key = md5(format("%s/%s", aws_s3_bucket.main.arn, aws_s3_bucket.main.hosted_zone_id))
}

resource "aws_cloudfront_origin_access_control" "main" {
  count = var.cloudfront == true ? 1 : 0

  name                              = aws_s3_bucket.main.bucket_regional_domain_name
  description                       = "S3: ${aws_s3_bucket.main.id}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "main" {
  count = var.cloudfront == true ? 1 : 0

  comment = "S3: ${aws_s3_bucket.main.id}"

  enabled             = true
  wait_for_deployment = false
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  http_version        = "http2and3"

  aliases = var.cloudfront_aliases

  logging_config {
    bucket          = aws_s3_bucket.logs[0].bucket_domain_name
    include_cookies = false
    prefix          = "cloudfront/"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.main.bucket_regional_domain_name
    viewer_protocol_policy = var.cloudfront_viewer_protocol_policy
    compress               = true

    min_ttl     = 60
    default_ttl = var.cloudfornt_default_ttl
    max_ttl     = var.cloudfront_max_ttl

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name              = var.website != null ? aws_s3_bucket_website_configuration.main[0].website_endpoint : aws_s3_bucket.main.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.main.bucket_regional_domain_name
    origin_access_control_id = var.website == null ? aws_cloudfront_origin_access_control.main[0].id : null

    custom_header {
      name  = "Referer"
      value = local.private_key
    }

    dynamic "custom_origin_config" {
      for_each = var.website != null ? [1] : []

      content {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
  }

  dynamic "viewer_certificate" {
    for_each = var.acm_certificate_arn != null ? [local.viewer_certificate_acm] : [local.viewer_certificate]

    content {
      cloudfront_default_certificate = lookup(viewer_certificate.value, "cloudfront_default_certificate", null)
      acm_certificate_arn            = lookup(viewer_certificate.value, "acm_certificate_arn", null)
      ssl_support_method             = lookup(viewer_certificate.value, "ssl_support_method", null)
    }
  }

  dynamic "custom_error_response" {
    for_each = var.cloudfront_errors

    content {
      error_caching_min_ttl = 60
      error_code            = custom_error_response.key
      response_code         = custom_error_response.key
      response_page_path    = custom_error_response.value
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = local.cloudfront_geo_restriction_type
      locations        = local.cloudfront_geo_restriction_locations
    }
  }

  depends_on = [
    aws_s3_bucket.logs,
    aws_s3_bucket_ownership_controls.logs,
  ]
}
