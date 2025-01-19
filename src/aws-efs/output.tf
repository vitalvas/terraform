output "efs_id" {
  value = aws_efs_file_system.main.id
}

output "efs_dns_name" {
  value = aws_efs_file_system.main.dns_name
}

output "sg_id" {
  value = aws_security_group.main.id
}
