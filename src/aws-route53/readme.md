# AWS Route53

## Example

```hcl
module "zone_example_com" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-route53?ref=master"

  name = "example.com"

  records = [
    {
      type = "MX"
      records = ["10 mail.example.com"]
    },
    {
      name = "_53847ab552e89dab623df6865f81ce7c"
      type = "CNAME"
      records = ["_f189dcf55ddd5138a79344ba6507054f.qwknvqrlct.acm-validations.aws"]
    },
    {
      name = "www"
      type = "A",
      alias = {
        name    = "cf-www-name.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
      }
    },
    {
      name = "www"
      type = "AAAA",
      alias = {
        name    = "cf-www-name.cloudfront.net"
        zone_id = "Z2FDTNDATAQYW2"
      }
    }
  ]
}
```

## Enable DNSSEC

```hcl
module "dnssec_key" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-route53-dnssec-key?ref=master"
}

module "zone_example_com" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-route53?ref=master"

  name = "example.com"

  dnssec_enabled = true
  dnssec_kms_keys = [
    { key_arn = module.dnssec_key.kms_key_arn }
  ]

}
```
