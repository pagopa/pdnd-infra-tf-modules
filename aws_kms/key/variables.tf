variable "deletion_window" {
  description = "Duration in days after which the key is deleted after destruction of the resource"
  type = number
  default = 30
}

variable "enable_key_rotation" {
  type = bool
  description = "Specifies whether key rotation is enabled"
  default = true
}

variable "description" {
  type = string
  description = "Usage description"
  default = "KMS key"
}

variable "alias" {
  type = string
  description = "Meaningfull name that identifies the key"
  default = null
}