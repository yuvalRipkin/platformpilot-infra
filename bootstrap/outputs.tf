output "s3_output" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "dynmoDB_table_name" {
  description = "dynamo db table ame"
  value       =  aws_dynamodb_table.terraform_locks.name
}