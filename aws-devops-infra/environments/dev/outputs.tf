#VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
output "default_security_group_id" {
  description = "Default security group ID from VPC module"
  value       = module.vpc.default_security_group_id
}

output "database_subnet_group" {
  description = "Database subnet group name for RDS"
  value       = module.vpc.database_subnet_group
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = module.vpc.natgw_ids
}

#RDS
output "rds_endpoint" {
  description = "PostgreSQL RDS endpoint"
  value       = module.rds_postgres.db_instance_endpoint
}

output "rds_username" {
  value = module.rds_postgres.db_instance_username
}

output "rds_db_name" {
  value = module.rds_postgres.db_instance_name
}

#Redis
output "redis_endpoint" {
  description = "Redis cluster endpoint"
  value       = module.redis_registry.cluster_address
}

# output "redis_subnet_group" {
#   description = "Subnet group name for Redis"
#   value       = module.redis_infra.redis_subnet_group
# }

output "redis_security_group_id" {
  description = "Security Group ID for Redis"
  value       = module.redis_infra.redis_security_group_id
}

output "zone_id" {
  value = module.route53.zone_id
}

output "ecr_repository_url" {
  description = "ECR repo for app image"
  value       = module.ecr.repository_url
}
output "external_dns_irsa_role_arn" {
  value       = module.external_dns_irsa.externaldns_role_arn
  description = "IRSA role ARN for External DNS"
}
output "opensearch_endpoint" {
  description = "OpenSearch domain endpoint"
  value       = module.opensearch.domain_endpoint
}
output "prometheus_url" {
  value       = "https://prometheus.${var.domain_name}"
  description = "Public URL for Prometheus UI"
}

output "grafana_url" {
  value       = "https://grafana.${var.domain_name}"
  description = "Public URL for Grafana UI (if enabled)"
}
output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "Name of the EKS Cluster"
}
output "prometheus_remote_write_secret_arn" {
  value       = module.secret_prometheus_remote_write.secret_arn
  description = "Secrets Manager ARN for Prometheus remote write credentials"
}
output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}
output "oidc_provider_url" {
  value = module.eks.cluster_oidc_issuer_url
}