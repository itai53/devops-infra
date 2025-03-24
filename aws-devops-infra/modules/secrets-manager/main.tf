resource "aws_secretsmanager_secret" "db_secret" {
    name        = var.secret_name
    description = var.description 
  lifecycle {
    prevent_destroy = true
  }
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode(var.secret_data)
}
