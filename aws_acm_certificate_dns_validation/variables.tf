variable "domain_name" {
  type        = string
  description = "The domain name of the issued certificate to be validated."
  default     = null
}

variable "zone_name" {
  type        = string
  description = "The Route53 Zone Name used for the DNS validation (it must be a public zone)."
  default     = null
}
