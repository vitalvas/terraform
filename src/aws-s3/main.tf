resource "aws_s3_bucket" "main" {
  bucket        = var.bucket_name
  bucket_prefix = var.bucket_prefix
}

resource "aws_s3_bucket_versioning" "main" {
  count = var.versioning == true ? 1 : 0

  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

locals {
  bucket_private_acl = var.website == null ? true : var.cloudfront != true
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = local.bucket_private_acl
  block_public_policy     = local.bucket_private_acl
  ignore_public_acls      = local.bucket_private_acl
  restrict_public_buckets = local.bucket_private_acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "main" {
  count = var.website != null ? 1 : 0

  bucket = aws_s3_bucket.main.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_website_configuration" "main" {
  count = var.website != null ? 1 : 0

  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = try(var.website.index_document, "index.html")
  }

  error_document {
    key = try(var.website.error_document, "error.html")
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  count  = length(local.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.main.id

  dynamic "rule" {
    for_each = local.lifecycle_rules

    content {
      id     = try(rule.value.id, "default")
      status = "Enabled"

      dynamic "transition" {
        for_each = try(flatten(rule.value.transitions), [])

        content {
          days          = try(transition.value.days, null)
          storage_class = try(transition.value.storage_class, null)
        }
      }

      # Max 1 block - expiration
      dynamic "expiration" {
        for_each = try(flatten([rule.value.expiration]), [])

        content {
          date                         = try(expiration.value.date, null)
          days                         = try(expiration.value.days, null)
          expired_object_delete_marker = try(expiration.value.expired_object_delete_marker, null)
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = try(flatten(rule.value.noncurrent_version_transition), [])

        content {
          noncurrent_days = noncurrent_version_transition.value.noncurrent_days
          storage_class   = noncurrent_version_transition.value.storage_class
        }
      }

      # Max 1 block - noncurrent_version_expiration
      dynamic "noncurrent_version_expiration" {
        for_each = try(flatten([rule.value.noncurrent_version_expiration]), [])

        content {
          noncurrent_days = try(noncurrent_version_expiration.value.noncurrent_days, null)
        }
      }
    }
  }

  depends_on = [
    aws_s3_bucket.main
  ]
}

resource "aws_s3_bucket_policy" "main" {
  count  = var.bucket_policy != null ? 1 : 0
  bucket = aws_s3_bucket.main.id
  policy = var.bucket_policy
}

resource "aws_s3_bucket_logging" "main" {
  count = var.logs_target_bucket != null ? 1 : 0

  bucket        = aws_s3_bucket.main.id
  target_bucket = var.logs_target_bucket
  target_prefix = "${var.logs_target_prefix}s3/"
}
