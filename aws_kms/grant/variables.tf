variable "name" {
  description = "KMS grant name"
  default = null
}
variable "key_id" {
  description = "KMS key id"
  default = null
}
variable "role_arn" {
  description = "ARN granted"
  default = null
}