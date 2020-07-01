variable "aws_region" {
  type = string

}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "owner" {
  type        = string
  description = "The Owner tag"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply. "
  default     = "private"
}

variable "versioning" {
  type = object({
    enabled    = bool
    mfa_delete = bool
  })
  default = {
    enabled    = false
    mfa_delete = false
  }
}

variable "logging" {
  type = object({
    target_bucket = string
    target_prefix = string
  })
  default = null
}

variable "policy" {
  type        = string
  description = "A valid bucket policy JSON document."
  default     = null
}

variable "server_side_encryption_configuration" {
  type = object({
    # (required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms
    sse_algorithm = string
    # (optional) The AWS KMS master key ID used for the SSE-KMS encryption.
    # This can only be used when you set the value of sse_algorithm as aws:kms.
    # The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms.
    kms_master_key_id = string
  })
  default = null
}

# aws_s3_bucket_public_access_block
variable "block_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should block public ACLs for this bucket. Defaults to false."
  default     = false
}

variable "block_public_policy" {
  type        = bool
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  default     = false
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false."
  default     = false
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false"
  default     = false
}

variable "website" {
  type = object({
    index_document           = string
    error_document           = string
    redirect_all_requests_to = string # Optional
    routing_rules            = string # Optional
  })
  default = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}
