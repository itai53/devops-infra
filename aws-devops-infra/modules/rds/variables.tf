variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "default_tags" {
  description = "Default tags to apply"
  type        = map(string)
}

variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}