# AWS IAM for OIDC with GitHub for Repo

## Example

```hcl
module "github-repo" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-iam-oidc-github-repo?ref=master"

  # github repo: https://github.com/pixconf/pixconf-docs
  repo_name = "pixconf/pixconf-docs"

  data = [
    {
      resources = [
        "arn:aws:s3:::pixconf.vitalvas.dev",
        "arn:aws:s3:::pixconf.vitalvas.dev/*",
        "cloudfront:CreateInvalidation",
      ]
      actions = [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "arn:aws:cloudfront::966137286427:distribution/AAAAAAAAAAAAA",
      ]
    }
  ]
}
```
