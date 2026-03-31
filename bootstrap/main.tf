# Provider block
provider "aws" {
  region = "us-east-1"
}

# S3 bucket for state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "platformpilot-tfstate-yuval-2026"
}

# Enable versioning on the bucket
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}