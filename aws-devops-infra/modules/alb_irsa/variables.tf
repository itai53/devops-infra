variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}
variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}