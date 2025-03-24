# ─────────────────────────────────────────────
# ECR Repository
# ─────────────────────────────────────────────
module "ecr" {
  source          = "../../modules/ecr"
  repository_name = "${var.project_name}-ecr"
  tags            = var.default_tags
}
# Pass ECR repository URL to Helm values
locals {
  app_image_repo = module.ecr.repository_url
}