provider "aws" {
  version = "2.62.0"
  region  = var.aws_region
}

resource "aws_db_subnet_group" "this" {
  count = var.db_subnet_group_name == null ? 0 : 1

  name        = var.db_subnet_group_name
  description = "Auorara subnet group ${var.db_subnet_group_name}"
  subnet_ids  = var.subnet_ids

  tags = merge({
    Environment = var.environment
  }, var.tags)

}

data "aws_secretsmanager_secret" "this" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "this" {
  secret_id     = "${data.aws_secretsmanager_secret.this.id}"
  version_stage = var.version_stage
}

resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.cluster_engine
  engine_mode             = var.engine_mode
  engine_version          = var.engine_version
  availability_zones      = var.availability_zones
  database_name           = var.database_name
  port                    = var.port
  master_username         = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string)[var.master_username_secret_key]
  master_password         = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string)[var.master_password_secret_key]
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window

  db_subnet_group_name = var.db_subnet_group_name != null ? aws_db_subnet_group.this[0].name : null

  vpc_security_group_ids = var.vpc_security_group_ids

  dynamic "scaling_configuration" {
    for_each = var.scaling_configuration != null ? [var.scaling_configuration] : []
    iterator = sc
    content {
      auto_pause               = sc.value.auto_pause
      max_capacity             = sc.value.max_capacity
      min_capacity             = sc.value.min_capacity
      seconds_until_auto_pause = sc.value.seconds_until_auto_pause
      timeout_action           = sc.value.timeout_action
    }
  }

  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  deletion_protection             = var.deletion_protection
  enable_http_endpoint            = var.engine_mode == "serverless" ? var.enable_http_endpoint : false
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  storage_encrypted               = var.storage_encrypted

  iam_roles = var.iam_roles

  tags = merge({
    Name        = var.cluster_identifier
    Environment = var.environment
  }, var.tags)

}
