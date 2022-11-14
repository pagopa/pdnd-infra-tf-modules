variable "source_file" {
  type        = string
  description = "The source file path"
}

variable "function_name" {
  type        = string
  description = "The Lambda function name"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}

variable "role" {
  type        = string
  description = "The function running role ARN"
}

variable "handler" {
  type        = string
  description = "The entrypoint function of the Lambda"
  default     = null
}

variable "timeout" {
  type        = number
  description = "The timeout for the function"
  default     = 900
}

variable "runtime" {
  type        = string
  description = "The function runtime"
}

variable "memory_size" {
  type        = number
  description = "The memory size"
  default     = 128
}
