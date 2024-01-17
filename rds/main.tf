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

# Creating database instance
resource "aws_db_instance" "instance" {
  engine                      = var.engine
  engine_version              = var.engine-version
  allocated_storage           = var.storage
  max_allocated_storage       = var.max-storage
  instance_class              = var.instance-type
  username                    = var.root-user
  manage_master_user_password = true
  identifier                  = local.instance-name
  port                        = var.db-port
  multi_az                    = var.multi-az
  db_subnet_group_name        = aws_db_subnet_group.subnet-group.name
  deletion_protection         = var.delete-protection
  vpc_security_group_ids      = [aws_security_group.db-sg.id]
  ca_cert_identifier          = var.certificate
  skip_final_snapshot         = var.skip-final-snapshot

  tags = {
    Name        = local.instance-name
    Environment = var.environment
    Project     = var.project
  }
}