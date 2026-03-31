locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
  engine = "postgres"
}

resource "aws_db_subnet_group" "rds" {
  subnet_ids = var.subnet_ids
  name       = "${var.project_name}-${var.environment}-rds-subnet-group"
  tags       = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-rds" })
}

resource "aws_db_instance" "rds" {
  instance_class          = var.instance_class
  engine                  = local.engine
  engine_version          = var.engine_version
  db_name                 = var.db_name
  allocated_storage       = var.allocated_storage
  storage_encrypted       = var.storage_encrypted
  username                = var.username
  password                = var.password
  multi_az                = var.multi_az
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  identifier              = "${var.project_name}-${var.environment}-rds"
  kms_key_id              = var.kms_key_id
  tags                    = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-rds" })
}
