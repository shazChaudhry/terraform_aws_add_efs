output "efs_file_system_id" {
  value       = aws_efs_file_system.efs.id
  description = "EFS file system ID"
}

# output "efs_file_system_dns_name" {
#   value       = aws_efs_file_system.efs.dns_name
#   description = "EFS file system DNS Name"
# }