variable "aws_region" {
  type = string
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "description" {
  type        = string
  description = "The description of the role."
  default     = null
}

variable "name" {
  type        = string
  description = "The name of the iam role."
}

variable "assume_role_policy" {
  type        = string
  description = "The policy that grants an entity permission to assume the role."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}

variable "policy_arn_attachments" {
  type    = list(string)
  default = []
}

variable "instance_profile_name" {
  type        = string
  description = "The name of the instance profile."
  default     = null

}
