resource "aws_security_group" "main" {
  name   = var.name
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "main" {
  for_each = var.ingress_rule

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = lookup(each.value, "cidr_ipv4", null)
  cidr_ipv6         = lookup(each.value, "cidr_ipv6", null)
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = lookup(each.value, "ip_protocol", -1)
}

resource "aws_vpc_security_group_egress_rule" "main" {
  for_each = var.egress_rule

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = lookup(each.value, "cidr_ipv4", null)
  cidr_ipv6         = lookup(each.value, "cidr_ipv6", null)
  from_port         = lookup(each.value, "from_port", null)
  to_port           = lookup(each.value, "to_port", null)
  ip_protocol       = lookup(each.value, "ip_protocol", -1)
}
