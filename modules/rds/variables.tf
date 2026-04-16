variable "subnet_ids" {
  description = "List of subnet IDs the RDS instance will be placed in. Should be private subnets."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the RDS instance."
  type        = list(string)
}

variable "engine_version" {
  description = "PostgreSQL engine version (e.g. 15.4)."
  type        = string
  default     = "15.4"
}

variable "db_name" {
  description = "Name of the initial database created on launch."
  type        = string
}

variable "instance_class" {
  description = "RDS instance class (e.g. db.t3.micro, db.m5.large)."
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial allocated storage size in GB. Must be between 20 and 65536."
  type        = number
  default     = 20
}

variable "storage_encrypted" {
  description = "Whether to encrypt RDS storage at rest. Requires kms_key_id if a custom key is needed."
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "ARN of the KMS key used to encrypt storage. If null, the default RDS KMS key is used."
  type        = string
  default     = null
}

variable "username" {
  description = "Master username for the RDS instance. Cannot be changed after creation."
  type        = string
  validation {
    condition     = length(var.username) > 2
    error_message = "Username must be longer than 2 characters."
  }
}

variable "deletion_protection" {
  description = "If true, prevents the RDS instance from being deleted. Recommended for production."
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enables a standby replica in a second AZ for automatic failover."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups. Set to 0 to disable."
  type        = number
  default     = 30
}

variable "skip_final_snapshot" {
  description = "If true, no final snapshot is taken on deletion. Set to false in production."
  type        = bool
  default     = true
}

variable "environment" {
  description = "Deployment environment. Used for resource tagging and naming."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "project_name" {
  type        = string
  description = "Project name tag that will be added to all resources"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to merge with the default tags applied to all resources."
  default     = {}
}
 
