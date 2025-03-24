variable "private_subnet_ids" {
  description = "List of private subnet IDs for Redis subnet group"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for Redis security group"
  type        = string
}

variable "default_tags" {
  description = "Tags to apply to Redis resources"
  type        = map(string)
}
