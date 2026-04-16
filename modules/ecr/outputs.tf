output "repo_url" {
  description = "The URL of the ECR repository, used to push and pull images (e.g. in docker push/pull commands)."
  value       = aws_ecr_repository.container_registry.repository_url
}

output "repo_arn" {
  description = "The ARN of the ECR repository, used for IAM policy bindings."
  value       = aws_ecr_repository.container_registry.arn
}