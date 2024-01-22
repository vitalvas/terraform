# AWS IAM for OIDC with GitHub

## Example

```hcl
module "iam_oidc_github" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-iam-oidc-github?ref=master"

  token_sub = [
    "repo:vitalvas/aws-account-config:ref:refs/heads/*",
  ]
}
```
