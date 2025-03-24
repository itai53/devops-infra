# ─────────────────────────────────────────────
# EKS Cluster
# ─────────────────────────────────────────────
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.34.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.32"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  cluster_endpoint_public_access       = true
  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  eks_managed_node_group_defaults = {
    instance_types = ["t4g.large"]
    ami_type       = "AL2_ARM_64"
  }

  eks_managed_node_groups = {
    statuspage_app_nodes = {
      desired_size = 1
      min_size     = 1
      max_size     = 1
    }
  }
  enable_cluster_creator_admin_permissions = true
  tags = var.default_tags
}
# ─────────────────────────────────────────────
# Update Kubeconfig Automatically After EKS
# ─────────────────────────────────────────────
resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}"
  }
  triggers = {
    always_run = timestamp()
  }
    depends_on = [
    module.eks
  ]
}  
