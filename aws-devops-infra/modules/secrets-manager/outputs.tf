output "secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}