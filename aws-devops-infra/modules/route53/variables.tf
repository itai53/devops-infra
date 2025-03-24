variable "domain_name" {
  description = "The domain name to register"
  type        = string
}

variable "app_record_name" {
  description = "Record name for app"
  type        = string
  default     = "app"
}
variable "tags" {
  type = map(string)
  default = {}
}
