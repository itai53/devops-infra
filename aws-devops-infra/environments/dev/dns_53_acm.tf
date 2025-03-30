# ─────────────────────────────────────────────
# Route53 + ACM (SSL)
# ─────────────────────────────────────────────
#Route53
module "route53" {
  source       = "../../modules/route53"
  domain_name  = var.domain_name
  app_record_name = "app"
  tags         = var.default_tags
}
#ACM
module "acm" {
  source      = "../../modules/acm"
  domain_name = var.domain_name
  zone_id     = module.route53.zone_id
  tags        = var.default_tags
}
resource "aws_route53_record" "opensearch_logs" {
  zone_id = module.route53.zone_id
  name    = "logs"
  type    = "CNAME"
  ttl     = 300
  records = [module.opensearch.domain_endpoint] 
}