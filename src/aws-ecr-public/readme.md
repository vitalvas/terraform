# AWS ECR Public

## Example

```hcl
module "ecr_infra_clamav" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-ecr-public?ref=master"
  name = "infra/clamav"
}
```
