# AWS SNS

## Example

```hcl
module "sns_backup" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-sns?ref=master"
  name   = "aws-backup"

  account_id         = local.account_id
  region_name        = local.region_name
  service_access     = "aws_backup"
  encryption_enabled = false

  subscriptions = [
    {
      protocol = "email"
      endpoint = "<email>"
    }
  ]
}
```
