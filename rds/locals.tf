# Security group name
locals {
  db-sg-name = "db-sg-${var.project}-${var.environment}"
}

# Subnet group name
locals {
  subnet-group-name = "subnet-group-${var.project}-${var.environment}"
}

# Instance name
locals {
  instance-name = "database-${var.project}-${var.environment}"
}