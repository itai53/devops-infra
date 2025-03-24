# ─────────────────────────────────────────────
# RDS PostgreSQL
# ─────────────────────────────────────────────
module "rds_infra" {
  source             = "../../modules/rds"
  name_prefix = "statuspage-db"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  default_tags       = var.default_tags
}
module "rds_postgres" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.11.0"

  identifier = var.rds_identifier
  engine     = "postgres"
  engine_version = "15.12"
  instance_class = var.rds_instance_class
  allocated_storage = 20

  db_name  = var.rds_db_name
  username = var.rds_db_username
  password = var.rds_db_password
  port     = 5432

  vpc_security_group_ids = [module.rds_infra.rds_security_group_id]
  db_subnet_group_name   = module.rds_infra.rds_subnet_group

  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  family = "postgres15"
  tags = var.default_tags
}