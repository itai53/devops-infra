# ─────────────────────────────────────────────
# Secrets Manager
# ─────────────────────────────────────────────
module "secrets_manager" {
  source        = "../../modules/secrets-manager"
  secret_name   = "${var.rds_db_name}-credentials-v3"
  secret_data = {
    username = var.rds_db_username
    password = var.rds_db_password
    db_name  = var.rds_db_name
    description = "Database credentials for RDS PostgreSQL-EI"
  }
  tags = var.default_tags
}
module "secret_opensearch_credentials" {
  source      = "../../modules/secrets-manager"
  secret_name = "opensearch-credentials-EI"
  secret_data = {
    username = var.opensearch_admin_user
    password = var.opensearch_admin_password
  }
  description = "Admin credentials for OpenSearch"
  tags = var.default_tags
}
module "secret_prometheus_remote_write" {
  source      = "../../modules/secrets-manager"
  secret_name = "prometheus-secret-for-cloud-EI"
  secret_data = {
    username = var.prometheus_remote_username
    password = var.prometheus_remote_password
    url      = var.prometheus_remote_url
  }
  description = "Prometheus remote write credentials for Grafana Cloud"
  tags = var.default_tags
  depends_on = [
  module.external_secrets_irsa
]
}
#------------

module "external_secrets_irsa" {
  source = "../../modules/external_secrets_irsa"

  role_name           = "external-secrets-irsa-role"
  namespace           = "external-secrets"
  service_account_name = "external-secrets"
  oidc_provider_arn   = module.eks.oidc_provider_arn
  oidc_provider_url   = module.eks.cluster_oidc_issuer_url

  policy_json         = file("${path.module}/../../modules/external_secrets_irsa/iam_policy.json")

  tags = var.default_tags
}
