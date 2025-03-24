# ─────────────────────────────────────────────
# OpenSearch
# ─────────────────────────────────────────────
module "opensearch" {
  source  = "terraform-aws-modules/opensearch/aws"
  version = "1.6.0"

  domain_name    = var.opensearch_domain_name
  engine_version = "OpenSearch_1.3"
  cluster_config = {
    instance_type  = "r6g.large.search"
    instance_count = 1
    zone_awareness_enabled = false
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
  tags = var.default_tags
}