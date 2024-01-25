# AWS SSO Permission Set

## Example

```hcl
locals {
  sso_permissions = {
    administrators = {
      name = "AdministratorAccess"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AdministratorAccess"
      ]
    },
    read_only = {
      name = "ReadOnlyAccess"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/ReadOnlyAccess"
      ]
    }
  }
}

module "sso_permission_set" {
  source = "git::git::https://github.com/vitalvas/terraform.git//src/aws-sso-permission-set?ref=master"

  for_each = local.sso_permissions

  instance_arn        = local.identity_instance_arn
  name                = try(each.value.name, each.key)
  description         = try(each.value.description, null)
  session_duration    = try(each.value.session_duration, null)
  managed_policy_arns = try(each.value.managed_policy_arns, [])
}
```
