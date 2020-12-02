variable "aws_region" {
  type = string
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "key_name" {
  type        = string
  description = "The name of the pulic key"
}

variable "secret_name" {
  type        = string
  description = "The secret manager secret name"
}

variable "secret_key_name" {
  type        = string
  description = "The name of the key within the secret"
}

variable "version_stage" {
  type        = string
  description = "Specifies the secret version that you want to retrieve by the staging label attached to the version. "
  default     = "AWSCURRENT"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}

variable "public_key_path_openssh" {
  description = "Public key path (generate it with ssh-keygen)"
}
variable "private_key_path_openssh" {
  description = "Private key path (generate it with ssh-keygen)"
}
