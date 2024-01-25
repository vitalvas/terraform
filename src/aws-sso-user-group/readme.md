# AWS SSO User and Group

## Example

```hcl
data "aws_ssoadmin_instances" "main" {}

locals {
  identity_store_id = data.aws_ssoadmin_instances.main.identity_store_ids[0]

  sso_users = {
    vitalvas = {
      first_name = "Vitaliy"
      last_name  = "V"
      email      = "<my email :)>"
      groups = [
        "sudoers",
        "administrators_prod"
      ]
    }
  }

  sso_groups = {
    sudoers = {
      description = "Provides access to Root AWS account"
    }

    administrators_prod = {
      description = "Provides access to AWS services and resources in Production environment"
    }
  }
}

module "sso_user_group" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-sso-user-group?ref=master"

  identity_store_id = local.identity_store_id
  users             = local.sso_users
  groups            = local.sso_groups
}
```
