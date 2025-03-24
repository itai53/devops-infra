variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "default_tags" {
  description = "Default tags"
  type        = map(string)
}

variable "oidc_provider_arn" {
  description = "The OIDC provider ARN from the EKS cluster"
  type        = string
}
variable "cluster_oidc_issuer_url" {
  description = "EKS cluster OIDC issuer URL"
  type        = string
}