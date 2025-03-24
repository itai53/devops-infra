variable "role_name" {}
variable "policy_json" {}
variable "oidc_provider_arn" {}
variable "oidc_provider_url" {}
variable "namespace" {}
variable "service_account_name" {}
variable "tags" {
  type = map(string)
}