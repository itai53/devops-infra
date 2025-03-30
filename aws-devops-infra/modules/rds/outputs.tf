output "rds_subnet_group" {
  description = "RDS Subnet Group Name"
  value       = aws_db_subnet_group.this.name
}

output "rds_security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.this.id
}
