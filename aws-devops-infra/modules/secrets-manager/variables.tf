variable "secret_name" {
  description = "Secret name"
  type        = string
}

variable "secret_data" {
  description = "Key-value pairs (JSON) for secret"
  type        = map(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "description" {
  type        = string
  description = "Secret description"
  default     = "Secret managed by Terraform"
}