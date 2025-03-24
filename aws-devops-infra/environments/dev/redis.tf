# ─────────────────────────────────────────────
# Redis (ElastiCache)
# ─────────────────────────────────────────────
module "redis_infra" {
  source              = "../../modules/redis"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnets
  default_tags        = var.default_tags
}
module "redis_registry" {
  source  = "terraform-aws-modules/elasticache/aws"
  version = "1.4.1"

  replication_group_id = var.replication_group_id 
  cluster_id           = var.redis_cluster_name
  engine               = "redis"
  engine_version       = "7.0"
  node_type            = var.redis_node_type
  num_cache_clusters   = 1
  parameter_group_name = "default.redis7"
  port                 = 6379

  subnet_ids             = module.vpc.private_subnets
  security_group_ids     = [module.redis_infra.redis_security_group_id]

  log_delivery_configuration = {
    "slow-log" = {
      destination_type = "cloudwatch-logs"
      log_format       = "text"
      log_type         = "slow-log"
      destination      = module.redis_infra.redis_log_group_name
    }
  }

  tags = var.default_tags
}