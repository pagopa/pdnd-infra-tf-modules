variable "bucket_arn" {
  type = string
  description = "Destination bucket ARN"
  default = null
}


variable "firehose_name" {
  type        = string
  description = "The name of the delivery stream."
  default     = null
}

variable "firehose_server_side_encryption" {
  type = map(string)
  description = "Server side encryption configuration"
  default = {
    enabled = false
    key_type = null
    key_arn = null
  }
}

variable "firehose_extended_s3_configurations" {
  type = map(string)
  description = "Extended S3 configurations"
  default = {
    bucket_arn = null
    prefix = null
    error_output_prefix = null
    buffer_size = 5
    buffer_interval = 60
    kms_key_arn = null
    cloudwatch_enabled = false
    cloudwatch_log_group = null
    cloudwatch_log_stream_name = null
  }
}

variable "firehose_iam_policy" {
  type = string
  description = "Firehose IAM policy"
  default = null
}