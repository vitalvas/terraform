variable "identity_store_id" {
  description = "The ID of the identity store to use for SSO"
  type        = string
}

variable "users" {
  description = "A list of users to create in the identity store"
  type        = any
}

variable "groups" {
  description = "A list of groups to create in the identity store"
  type        = any
}
