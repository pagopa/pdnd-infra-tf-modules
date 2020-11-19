variable "function_name" {
  description = "Lambda function name"
  type = string
  default = null
}

variable "function_handler" {
  description = "Lambda function handler"
  type = string
  default = null
}

variable "function_runtime" {
  description = "Lambda function runtime"
  type = string
  default = null
}

variable "function_memory_size" {
  description = "Memory size"
  type = number
  default = 512
}

variable "deployment_s3_location" {
  description = "Deployment references"
  type = map(string)
  default = {
    s3_bucket = null
    s3_key = null
    s3_object_version = null
  }
}

variable "function_env" {
  description = "Environment variables"
  type = map(string)
  default = null
}

variable "function_vpc_config" {
  description = "VPC config"
  type = map(list(string))
  default = {
    security_group_ids = null
    subnet_ids = null
  }
}

variable "function_policy" {
  description = "Lambda function policy document"
  type = string
  default = null
}