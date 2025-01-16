variable "report_name" {
  description = "Name of the billing report"
  type        = string
}

variable "time_unit" {
  description = "The granularity of the report data (HOURLY, DAILY)"
  type        = string
  default     = "HOURLY"
}

variable "format" {
  description = "The format of the report (textORcsv, Parquet)"
  type        = string
  default     = "textORcsv"
}

variable "compression" {
  description = "The compression format for the report (GZIP, ZIP, Parquet)"
  type        = string
  default     = "GZIP"
}

variable "additional_schema_elements" {
  description = "Additional schema elements (e.g., RESOURCES)"
  type        = list(string)
  default     = ["RESOURCES"]
}

variable "reports_s3_prefix" {
  description = "S3 prefix for the billing reports"
  type        = string
  default     = "reports"
}

variable "refresh_closed_reports" {
  description = "Whether to refresh closed reports"
  type        = bool
  default     = true
}

variable "report_versioning" {
  description = "Versioning for the reports (OVERWRITE_REPORT, CREATE_NEW_REPORT)"
  type        = string
  default     = "OVERWRITE_REPORT"
}

variable "additional_artifacts" {
  description = "Additional artifacts for the report (e.g., REDSHIFT, QUICKSIGHT)"
  type        = list(string)
  default     = []
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}
