# Database security group ID
output "db-sg-id" {
  value = aws_security_group.db-sg.id
}

# Subnet group ID
output "subnet-group-id" {
  value = aws_db_subnet_group.subnet-group.id
}

# Instance ID
output "database-id" {
  value = aws_db_instance.instance.id
}