# AWS Budget

## Example

```hcl
module "budget_root" {
  source       = "git::https://github.com/vitalvas/terraform.git//src/aws-budget?ref=master"
  account_id   = local.account_id
  budget_name  = "Account_Root"
  limit_amount = "80.0"

  subscriber_email_addresses = ["<email>"]
}

module "budget_chatbots" {
  source       = "git::https://github.com/vitalvas/terraform.git//src/aws-budget?ref=master"
  account_id   = local.account_id
  budget_name  = "Account_ChatBots"
  limit_amount = "30.0"

  subscriber_email_addresses = ["<email>"]

  cost_filters = {
    "LinkedAccount" = ["<account id>"]
  }
}
```
