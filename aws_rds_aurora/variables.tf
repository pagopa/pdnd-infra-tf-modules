variable "aws_region" {
  type = string

}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "owner" {
  type        = string
  description = "The Owner tag"
}

variable "db_subnet_group_name" {
  type        = string
  default     = null
  description = "A DB subnet group to associate with this DB instance"
}

variable "subnet_ids" {
  type        = list(string)
  description = ""
  default     = []
}

variable "cluster_identifier" {
  type        = string
  description = "The cluster identifier."
}

variable "cluster_engine" {
  type        = string
  description = "The name of the database engine to be used for this DB cluster."
  default     = "aurora"
}

variable "engine_mode" {
  type        = string
  default     = "provisioned"
  description = "The database engine mode."
}

variable "engine_version" {
  type        = string
  description = "The database engine version."
  default     = null
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created."
  default     = []
}

variable "database_name" {
  type        = string
  description = "Name for an automatically created database on cluster creation"
  default     = null
}

variable "port" {
  type        = number
  description = "The port on which the DB accepts connections"
  default     = null
}

# Secret configuration

variable "secret_name" {
  type        = string
  description = "The secret name containg the username and password"
}

variable "version_stage" {
  type        = string
  description = "The version of the secret."
  default     = "AWSCURRENT"
}

variable "master_username_secret_key" {
  type        = string
  description = "The name of the key containing in the key store the database username"
}

variable "master_password_secret_key" {
  type        = string
  description = "The name of the key containing in the key store the database password"
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for. Default 1"
  default     = 1
}

variable "preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter."
  default     = "04:00-09:00"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security groups to associate with the Cluster"
  default     = []
}

variable "scaling_configuration" {
  type = object({
    auto_pause               = bool
    max_capacity             = number
    min_capacity             = number
    seconds_until_auto_pause = number
    timeout_action           = string
  })
  default = null
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy all Cluster tags to snapshots."
  default     = false
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled. "
  default     = false
}

variable "enable_http_endpoint" {
  type        = bool
  description = "Enable HTTP endpoint (data API)."
  default     = false
}


variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to export to cloudwatch. If omitted, no logs will be exported."
  default     = []
}

variable "storage_encrypted" {
  type        = string
  description = "Specifies whether the DB cluster is encrypted."
  default     = true
}

variable "iam_roles" {
  type        = list(string)
  description = "A List of ARNs for the IAM roles to associate to the RDS Cluster."
  default     = []
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created."
  default     = false
}


# db instance
variable "cluster_instances_count" {
  type        = number
  default     = 1
  description = "The number of instances to include in the cluster."
}

variable "instance_identifier" {
  type        = string
  description = "The identifier for the RDS instance"
}

variable "instance_class" {
  type        = string
  description = "The instance class to use."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}


variable "master_username" {
  type = string
  default = null
}
variable "master_password" {
  type = string
  default = null
}
variable "db_engine" {
  type = string
  default = null
}
variable "db_host" {
  type = string
  default = null
}
variable "db_port" {
  type = number
  default = null
}
variable "db_dbname" {
  type = string
  default = null
}