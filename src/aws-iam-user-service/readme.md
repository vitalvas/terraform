# AWS IAM User - Service Account

## Example

```hcl
module "sa_user_salsa" {
  source   = "git::https://github.com/vitalvas/terraform.git//src/aws-iam-user-service?ref=master"
  name     = "salsa"

  resources   = [
    "arn:aws:s3:::my-great-bucket",
  ]
  allowed_ips = [
    "192.0.2.2/32", "2001:db8::11/128"
  ]
}
```
