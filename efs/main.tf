# Creating security group
resource "aws_security_group" "efs-sg" {
  name        = local.efs-sg-name
  description = "Security group used by EFS of project ${var.project} of ${var.environment} environment"
  vpc_id      = var.vpc-id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
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
    Name        = local.efs-sg-name
    Environment = var.environment
    Project     = var.project
  }
}

# Creating EFS
resource "aws_efs_file_system" "efs" {
  creation_token                  = local.efs-name
  encrypted                       = var.encryption
  kms_key_id                      = var.kms-key-id
  performance_mode                = var.performance-mode
  throughput_mode                 = var.throughput-mode
  provisioned_throughput_in_mibps = var.throughput-mode == "provisioned" ? var.provisioned-mibps : null

  lifecycle_policy {
    transition_to_ia = var.transition-to-ia
  }

  tags = {
    Name        = local.efs-name
    Environment = var.environment
    Project     = var.project
  }
}

# Creating mount targets
resource "aws_efs_mount_target" "mount-targets" {
  for_each = {
    "mount-target-01" = { subnet_id = "${var.application-subnet-01-id}" }
    "mount-target-02" = { subnet_id = "${var.application-subnet-02-id}" }
  }

  subnet_id       = each.value.subnet_id
  file_system_id  = aws_efs_file_system.efs.id
  security_groups = [aws_security_group.efs-sg.id]
}

# Automatic backup
resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id

  backup_policy {
    status = var.backup
  }
}