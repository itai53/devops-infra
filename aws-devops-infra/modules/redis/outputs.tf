output "redis_security_group_id" {
  description = "Security Group ID for Redis"
  value       = aws_security_group.redis.id
}
output "redis_security_group_vpc_id" {
  value = aws_security_group.redis.vpc_id
}
output "redis_log_group_name" {
  value = aws_cloudwatch_log_group.redis_slow_log.name
}