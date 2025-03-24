resource "aws_cloudwatch_log_group" "redis_slow_log" {
  name = "/aws/elasticache/devops-redis-EI"
  retention_in_days = 7
  tags = var.default_tags
   lifecycle {
    prevent_destroy = true
  }
}
resource "aws_security_group" "redis" {
  name        = "redis-sg"
  description = "Redis access security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.default_tags
}
