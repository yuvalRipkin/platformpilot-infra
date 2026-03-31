variable "cluster_name" {
  description = "Name of the EKS cluster. Used for resource naming and tagging"
  type        = string
}

variable "cluster_version" {
  description = "The desired Kubernetes version for your EKS cluster."
  type        = string
  default     = "1.31"

  validation {
    condition     = can(regex("^1\\.(2[4-9]|[3-9][0-9])$", var.cluster_version))
    error_message = "The cluster_version must be a valid EKS version, such as '1.30' or '1.31'."
  }
}

variable "vpc_id" {
  description = "The ID of the VPC the cluster will be deployed in."
  type        = string
}

variable "private_subnets_ids" {
  description = "List of private subnet IDs for EKS worker nodes and ENIs."
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for EKS worker nodes (e.g. t3.medium, m5.large)."
  type        = string
  default     = "t3.medium"
}

variable "node_min" {
  description = "Minimum number of worker nodes in the autoscaling group."
  type        = number
  default     = 2

  validation {
    condition     = var.node_min >= 1
    error_message = "The minimum nodes required is one."
  }
}

variable "node_max" {
  description = "Maximum number of worker nodes in the autoscaling group."
  type        = number
  default     = 5

  validation {
    condition     = var.node_max >= 1
    error_message = "node_max must be at least 1."
  }
}

variable "node_desired" {
  description = "Desired number of worker nodes at launch."
  type        = number
  default     = 2

  validation {
    condition     = var.node_desired >= 1
    error_message = "The minimum desired nodes required is one."
  }
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
  default     = "platformpilot"
}