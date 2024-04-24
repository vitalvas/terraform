variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rules" {
  type = map(object({
    from_port   = optional(number, -1)
    to_port     = optional(number, -1)
    ip_protocol = optional(string, "-1")
    cidr_ipv4   = optional(string, null)
    cidr_ipv6   = optional(string, null)
    description = optional(string, null)
  }))

  default = {
    "allow-icmp-ipv4" = {
      ip_protocol = "icmp"
      cidr_ipv4   = "0.0.0.0/0"
    }
    "allow-icmp-ipv6" = {
      ip_protocol = "icmp"
      cidr_ipv6   = "::/0"
    }
  }
}

variable "egress_rules" {
  type = map(object({
    from_port   = optional(number, -1)
    to_port     = optional(number, -1)
    ip_protocol = optional(string, "-1")
    cidr_ipv4   = optional(string, null)
    cidr_ipv6   = optional(string, null)
    description = optional(string, null)
  }))

  default = {
    "allow-all-ipv4" = {
      cidr_ipv4 = "0.0.0.0/0"
    }
    "allow-all-ipv6" = {
      cidr_ipv6 = "::/0"
    }
  }
}
