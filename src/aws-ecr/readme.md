# AWS ECR

## Example

```hcl
module "ecr_infra_clamav" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-ecr?ref=master"
  name = "infra/clamav"
}
```
