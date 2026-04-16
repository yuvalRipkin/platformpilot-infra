terraform {
     required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "platformpilot-tfstate-yuval-2026"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  environment        = "dev"
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = "platformpilot-dev"
  cluster_version    = "1.31"
  vpc_id             = module.vpc.vpc_id
  private_subnets_ids = module.vpc.private_subnets_ids
  environment        = "dev"
}

resource "aws_kms_key" "ecr" {
  description             = "KMS key for ECR image encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "ecr" {
  name          = "alias/platformpilot-ecr"
  target_key_id = aws_kms_key.ecr.key_id
}

module "ecr" {
  source               = "../../modules/ecr"
  repo_name            = "platformpilot-operator"
  kms_key_arn          = aws_kms_key.ecr.arn
  image_max_count      = 5
  image_tag_mutability = "IMMUTABLE"
}