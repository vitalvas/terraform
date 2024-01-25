resource "aws_identitystore_group" "main" {
  for_each = var.groups

  identity_store_id = var.identity_store_id

  display_name = each.key
  description  = each.value.description
}

resource "aws_identitystore_group_membership" "main" {
  for_each = local.users_groups_membership

  identity_store_id = var.identity_store_id

  group_id  = aws_identitystore_group.main[each.value["group"]].group_id
  member_id = aws_identitystore_user.main[each.value["user"]].user_id

  depends_on = [
    aws_identitystore_group.main
  ]
}

output "groups" {
  value = aws_identitystore_group.main
}
