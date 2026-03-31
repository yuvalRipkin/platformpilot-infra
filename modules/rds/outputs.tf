output "endpoint" {
  description = "The hostname and port of the RDS instance. Used as the connection endpoint."
  value = aws_db_instance.rds.endpoint
}

output "port" {
  description = "The port the RDS instance listens on for incoming connections."
  value = aws_db_instance.rds.port
}

output "db_name" {
  description = "The name of the initial database. Used as part of the connection string."
  value = aws_db_instance.rds.db_name
}

output "address" {
  description = "The hostname of the RDS instance, without the port."
  value = aws_db_instance.rds.address
}

output "id" {
  description = "The RDS instance ID, useful for referencing in other modules or IAM policies"
  value = aws_db_instance.rds.id
}