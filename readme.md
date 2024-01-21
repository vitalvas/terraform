# Terraform modules

This repository contains a collection of Terraform modules for deploying various common infrastructure patterns on one or more cloud providers.

## Usage

```hcl
module "test" {
  source = "git::https://github.com/vitalvas/terraform.git//src/<module name>?ref=master"
}
```

### Example

```hcl
module "zone" {
  source     = "git::https://github.com/vitalvas/terraform.git//src/cloudflare-zone?ref=master"
  name       = "vitalvas.dev"
  account_id = "..."

  records = []
}
```
