resource "aws_ec2_instance_connect_endpoint" "main" {
  for_each = toset(var.subnet_ids)

  subnet_id          = each.key
  security_group_ids = var.security_group_ids
  preserve_client_ip = var.preserve_client_ip
}
