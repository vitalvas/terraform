output "bucket_name" {
  description = "Actual bucket name, including the namespace suffix when account-regional."
  value       = aws_s3_bucket.main.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.main.bucket_regional_domain_name
}
