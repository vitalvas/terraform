# AWS Security Group

## Example

```hcl
module "security_group" {
  source = "git::https://github.com/vitalvas/terraform.git//src/aws-security-group?ref=master"

  name   = "my-security-group"
  vpc_id = "vpc-0ffffffffffffffff"

  ingress_rules = {
    "ssh-any-ipv4" : { from_port = 22, to_port = 22, ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
    "ssh-any-ipv6" : { from_port = 22, to_port = 22, ip_protocol = "tcp", cidr_ipv6 = "::/0" },
  }
}
```
