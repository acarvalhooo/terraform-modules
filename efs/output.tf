# EFS security group ID
output "efs-sg-id" {
  value = aws_security_group.efs-sg.id
}

# EFS ID
output "efs-id" {
  value = aws_efs_file_system.efs.id
}