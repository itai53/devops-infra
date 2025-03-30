# ─────────────────────────────────────────────
# OpenSearch
# ─────────────────────────────────────────────
data "aws_caller_identity" "current" {}
module "opensearch" {
  source  = "terraform-aws-modules/opensearch/aws"
  version = "1.6.0"

  domain_name    = var.opensearch_domain_name
  engine_version = "OpenSearch_2.17"

  cluster_config = {
    instance_type           = "r6g.large.search"
    instance_count          = 1
    zone_awareness_enabled  = false
  }

  ebs_options = {
    volume_size = var.ebs_volume_size
    volume_type = "gp3"
  }
  advanced_security_options = {
    enabled                         = true
    internal_user_database_enabled = true
    master_user_options = {
      master_user_name     = var.opensearch_admin_user
      master_user_password = var.opensearch_admin_password
    }
  }
  vpc_options = {}
  domain_endpoint_options = {
    enforce_https                   = true
    tls_security_policy             = "Policy-Min-TLS-1-2-2019-07"
    custom_endpoint_enabled         = true
    custom_endpoint                 = "logs.imlinfo.xyz"
    custom_endpoint_certificate_arn = module.acm.certificate_arn
  }

  access_policies = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "es:*",
        Resource = "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.opensearch_domain_name}/*"
      }
    ]
  })

  tags = var.default_tags
}

# ─────────────────────────────────────────────
# OpenSearch Access Policy
# ─────────────────────────────────────────────
resource "aws_opensearch_domain_policy" "fluentbit_policy" {
  domain_name = "status-page-secrets-ei"  

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::992382545251:role/fluentbit-role"
        }
        Action    = [
          "es:ESHttpGet",
          "es:ESHttpPost",
          "es:ESHttpPut",
          "es:ESHttpHead"
        ]
        Resource  = "arn:aws:es:us-east-1:992382545251:domain/status-page-secrets-ei/*"
      }
    ]
  })
}