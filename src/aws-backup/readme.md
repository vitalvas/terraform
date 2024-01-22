# AWS Backup

## Example

```hcl
module "s3_backup" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-backup?ref=master"
  aws_service = "s3"
  name        = "my-great-bucket"

  resources = [
    "arn:aws:s3:::my-great-bucket",
  ]
}
```
