locals {
  extract_users_groups_only = {
    for user, user_data in var.users : user => user_data.groups
  }

  users_groups_combined = [
    for user, groups in local.extract_users_groups_only : {
      for group in groups : "${user}-${group}" => {
        user  = user
        group = group
      }
    }
  ]

  users_groups_membership = zipmap(
    flatten([for item in local.users_groups_combined : keys(item)]),
    flatten([for item in local.users_groups_combined : values(item)])
  )
}
