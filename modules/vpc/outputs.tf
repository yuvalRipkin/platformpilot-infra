output "vpc_id" {
  description = "The vpc id"
  value = aws_vpc.main_vpc.id
}

output "public_subnets_ids" {
  description = "The public subnets id"
  value = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  description = "The private subnets ids"
  value = aws_subnet.private[*].id
}