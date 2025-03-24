variable "domain_name" {
  type = string
}

variable "zone_id" {
  description = "Route53 Hosted Zone ID for DNS validation"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
