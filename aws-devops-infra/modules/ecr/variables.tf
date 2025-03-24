variable "repository_name" {
  description = "Name of ECR repository"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags for ECR repository"
  default     = {}
}