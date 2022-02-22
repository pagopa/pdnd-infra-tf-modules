variable "aws_region" {
  type = string
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "project_name" {
  type        = string
  description = "The name of the project."
}

variable "ip_set_name" {
  type        = string
  description = "The name of the IP Set."
}

variable "ip_set_description" {
  type        = string
  description = "A friendly description of the IP set."
  default = "WAF IP Set"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}

variable "ip_set_address_version" {
  type        = string
  description = "Specify IPV4 or IPV6. Valid values are IPV4 or IPV6."
  default     = "IPV4"
}

variable "scope" {
  type        = string
  description = "pecifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL. To work with CloudFront, you must also specify the Region US East (N. Virginia)."
  default     = "REGIONAL"
}

variable "ip_set_addresses" {
  type        = list
  description = "Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR) notation. AWS WAF supports all address ranges for IP versions IPv4 and IPv6."
  default     = ["0.0.0.0/0"]
}

# Variables used to define if default action will be "allow" or "block"

variable "default_action_allow" {
  type        = list
  description = "Set one value only to have default action to allow, only one between default_action_allow and default_action_block can be set"
}

variable "default_action_block" {
  type        = list
  description = "Set one value only to have default action to block, only one between default_action_allow and default_action_block can be set"
}