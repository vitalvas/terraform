variable "name" {
  description = "The name of the EFS file system"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID in which to create the EFS file system"
  type        = string
}

variable "cidr_blocks" {
  type    = list(string)
  default = []
}

variable "ipv6_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "transition_to_ia" {
  type    = list(string)
  default = []
  validation {
    condition = (
      length(var.transition_to_ia) == 1 ? contains(["AFTER_1_DAY", "AFTER_7_DAYS", "AFTER_14_DAYS", "AFTER_30_DAYS", "AFTER_60_DAYS", "AFTER_90_DAYS", "AFTER_180_DAYS", "AFTER_270_DAYS", "AFTER_365_DAYS"], var.transition_to_ia[0]) : length(var.transition_to_ia) == 0
    )
    error_message = "Var `transition_to_ia` must either be empty list or one of \"AFTER_1_DAY\", \"AFTER_7_DAYS\", \"AFTER_14_DAYS\", \"AFTER_30_DAYS\", \"AFTER_60_DAYS\", \"AFTER_90_DAYS\", \"AFTER_180_DAYS\", \"AFTER_270_DAYS\", \"AFTER_365_DAYS\"."
  }
}

variable "transition_to_archive" {
  type    = list(string)
  default = []
  validation {
    condition = (
      length(var.transition_to_archive) == 1 ? contains(["AFTER_1_DAY", "AFTER_7_DAYS", "AFTER_14_DAYS", "AFTER_30_DAYS", "AFTER_60_DAYS", "AFTER_90_DAYS", "AFTER_180_DAYS", "AFTER_270_DAYS", "AFTER_365_DAYS"], var.transition_to_archive[0]) : length(var.transition_to_archive) == 0
    )
    error_message = "Var `transition_to_archive` must either be empty list or one of \"AFTER_1_DAY\", \"AFTER_7_DAYS\", \"AFTER_14_DAYS\", \"AFTER_30_DAYS\", \"AFTER_60_DAYS\", \"AFTER_90_DAYS\", \"AFTER_180_DAYS\", \"AFTER_270_DAYS\", \"AFTER_365_DAYS\"."
  }
}

variable "transition_to_primary_storage_class" {
  type    = list(string)
  default = []
  validation {
    condition = (
      length(var.transition_to_primary_storage_class) == 1 ? contains(["AFTER_1_ACCESS"], var.transition_to_primary_storage_class[0]) : length(var.transition_to_primary_storage_class) == 0
    )
    error_message = "Var `transition_to_primary_storage_class` must either be empty list or \"AFTER_1_ACCESS\"."
  }
}
