# VPC
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "devops-vpc" # change name
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "default_tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Project     = "final-devops-EI"
    Owner       = "itaimoshe"
  }
}

variable "public_subnet_tags" {
  description = "Tags specific to public subnets"
  type        = map(string)
  default = {
    "kubernetes.io/role/elb" = "1"
    Name                     = "devops-public-subnet"
  }
}

variable "private_subnet_tags" {
  description = "Tags specific to private subnets"
  type        = map(string)
  default = {
    "kubernetes.io/role/internal-elb" = "1"
    Name                              = "devops-private-subnet"
  }
}

# RDS
variable "rds_identifier" {
  type    = string
  default = "devops-postgres"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "rds_db_name" {
  description = "Actual name of the RDS PostgreSQL database"
  type        = string
}

variable "rds_username" {
  type    = string
  default = "postgres"
}
variable "rds_endpoint" {
  type    = string
  default = "url of postgres"
}

variable "rds_db_password" {
  description = "Password for RDS PostgreSQL"
  type        = string
  sensitive   = true
}

# Redis
variable "redis_cluster_name" {
  default = "devops-redis"
}

variable "redis_node_type" {
  default = "cache.t4g.micro"
}

variable "replication_group_id" {
  type = string
}

# Route53
variable "domain_name" {
  description = "Your Route53 domain name"
  type        = string
}

# EKS / Cluster
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}
variable "rds_db_username" {
  description = "Username for RDS PostgreSQL"
  type        = string
}

variable "project_name" {
  description = "Project-level identifier used for naming"
  type        = string
}
# variable "db_name" {
#   description = "Name prefix for RDS and related resources like secrets"
#   type        = string
# }

variable "enable_alb_lookup" {
  description = "Toggle ALB lookup output for WAF module"
  type        = bool
  default     = true
}

variable "ebs_volume_size" {
  default     = 10
  description = "EBS volume size for OpenSearch"
}

variable "opensearch_domain_name" {
  description = "OpenSearch Domain name"
  type        = string
  sensitive   = true
}
variable "opensearch_admin_user" {
  description = "OpenSearch admin user"
  type        = string
  sensitive   = true
}
variable "opensearch_admin_password" {
  description = "OpenSearch admin password"
  type        = string
  sensitive   = true
}
variable "prometheus_remote_username" {
  description = "prometheus username"
  type        = string
  sensitive   = true
}

variable "prometheus_remote_password" {
  description = "prometheus password"
  type        = string
  sensitive   = true
}

variable prometheus_remote_url{
  description = "prometheus url"
  type        = string
  sensitive   = true
}