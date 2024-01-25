resource "aws_identitystore_user" "main" {
  for_each = var.users

  identity_store_id = var.identity_store_id

  user_name    = each.key
  display_name = "${each.value.first_name} ${each.value.last_name}"

  name {
    given_name  = each.value.first_name
    family_name = each.value.last_name
  }

  emails {
    primary = true
    value   = each.value.email
  }
}
