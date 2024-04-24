# AWS Security Group

## Example

```hcl
module "security_group" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-security-group?ref=master"

  name   = "my-security-group"
  vpc_id = "vpc-0ffffffffffffffff"

  ingress_rule = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
  ]

  egress_rule = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_ipv4 = "0.0.0.0/0" },
    { from_port = 0, to_port = 0, protocol = "-1", cidr_ipv6 = "::/0" },
  ]
}
```
