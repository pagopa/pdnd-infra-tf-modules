variable "name" {
  type        = string
  description = "The EventBridge rule name"
}

variable "description" {
  type        = string
  description = "The EventBridge rule description"
}

variable "schedule" {
  type        = string
  description = "AWS Schedule expression"
}

variable "lambda_arn" {
  type        = string
  description = "The rule target Lambda ARN"
}

variable "tags" {
  type        = map(string)
  description = "The rule tags"
  default     = {}
}
