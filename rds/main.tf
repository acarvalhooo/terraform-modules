# Creating security group
resource "aws_security_group" "db-sg" {
  name        = local.db-sg-name
  description = "Security group used by database of project ${var.project} of ${var.environment} environment"
  vpc_id      = var.vpc-id

  ingress {
    from_port       = var.db-port
    to_port         = var.db-port
    protocol        = var.protocol
    cidr_blocks     = var.inbound-cidrs
    security_groups = var.sg-ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = local.db-sg-name
    Environment = var.environment
    Project     = var.project
  }
}

# Creating subnet group
resource "aws_db_subnet_group" "subnet-group" {
  name        = local.subnet-group-name
  description = "Subnet group of project ${var.project} of ${var.environment} environment"
  subnet_ids  = [var.database-subnet-01-id, var.database-subnet-02-id]

  tags = {
    Name        = local.subnet-group-name
    Environment = var.environment
    Project     = var.project
  }
}