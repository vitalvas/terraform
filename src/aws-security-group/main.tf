resource "aws_security_group" "main" {
  name   = var.name
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "main" {
  for_each = var.ingress_rules

  security_group_id = aws_security_group.main.id

  description = each.value.description
  cidr_ipv4   = each.value.cidr_ipv4
  cidr_ipv6   = each.value.cidr_ipv6
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol

  tags = {
    Name = each.key
  }
}

resource "aws_vpc_security_group_egress_rule" "main" {
  for_each = var.egress_rules

  security_group_id = aws_security_group.main.id

  description = each.value.description
  cidr_ipv4   = each.value.cidr_ipv4
  cidr_ipv6   = each.value.cidr_ipv6
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.ip_protocol

  tags = {
    Name = each.key
  }
}
