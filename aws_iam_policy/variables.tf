variable "aws_region" {
  type = string
}

variable "name" {
  type        = string
  description = "The name of the policy. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "description" {
  type        = string
  description = "Description of the IAM policy."
  default     = null
}

variable "path" {
  type        = string
  description = "Path in which to create the policy."
  default     = "/"
}

variable "policy" {
  type        = string
  description = "The policy document. This is a JSON formatted string"
}
