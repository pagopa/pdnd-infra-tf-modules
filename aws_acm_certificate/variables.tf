variable "aws_region" {
  type = string
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "self_signed" {
  type        = bool
  description = "Create a self signed certificate"
  default     = false
}

variable "common_name" {
  type        = string
  description = "Certificate common name."
  default     = null
}

variable "organization" {
  type        = string
  description = "Certificate organization."
  default     = null
}

variable "validity_period_hours" {
  type        = number
  description = "Certificate validity period"
  default     = 12
}

variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued."
  default     = null
}

variable "validation_method" {
  type        = string
  description = "Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}
