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

# Creating aurora cluster
resource "aws_rds_cluster" "cluster" {
  db_subnet_group_name        = aws_db_subnet_group.subnet-group.name
  cluster_identifier          = local.cluster-name
  availability_zones          = var.availability-zones
  allocated_storage           = 100
  iops                        = 1000
  db_cluster_instance_class   = "db.r5.medium"
  storage_type                = ""
  engine                      = var.engine
  engine_version              = var.engine-version
  master_username             = var.root-user
  manage_master_user_password = true
  deletion_protection         = var.delete-protection
  port                        = var.db-port
  vpc_security_group_ids      = [aws_security_group.db-sg.id]
  storage_encrypted           = true
  skip_final_snapshot         = true

  tags = {
    Name        = local.cluster-name
    Environment = var.environment
    Project     = var.project
  }
}

# # Creating aurora instance
# resource "aws_rds_cluster_instance" "writer_instance" {
#   engine             = aws_rds_cluster.cluster.engine
#   engine_version     = aws_rds_cluster.cluster.engine_version
#   identifier         = local.identifier
#   cluster_identifier = aws_rds_cluster.cluster.id
#   instance_class     = "db.t3.medium"
#   apply_immediately  = true
#   ca_cert_identifier = "rds-ca-ecc384-g1"

#   tags = {
#     Name        = local.identifier
#     Environment = var.environment
#   }
# }