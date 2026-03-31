variable "vpc_name" {
  type        = string
  description = "Name tag for the VPC"
  default     = "main-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  description = "List of all private subnets CIDR blocks"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enables a NAT Gateway so private subnets can reach the internet."
  default     = true
}

variable "project_name" {
  type        = string
  description = "Project name tag that will be added to all resources"
  default     = "platformpilot"
}

variable "environment" {
  type        = string
  description = "Deployment environment. Used for resource tagging and naming."
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AWS availability zones to deploy subnets into (e.g. us-east-1a)."
  default     = ["us-east-1a", "us-east-1b"]
}
