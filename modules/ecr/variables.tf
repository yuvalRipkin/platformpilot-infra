variable "repo_name" {
  description = "The name of the ECR repository where Docker images will be pushed and pulled."
  type = string
}

variable "image_tag_mutability" {
  description = "Controls whether image tags can be overwritten. Use MUTABLE to allow tag overwrites or IMMUTABLE to enforce unique tags per image."
  type    = string
  default = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be either \"MUTABLE\" or \"IMMUTABLE\"."
  }
}

variable "image_max_count" {
  description = "The amount of built images versions that will be stored."
  type    = number
  default = 10
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt images at rest in the repository."
  type = string
}