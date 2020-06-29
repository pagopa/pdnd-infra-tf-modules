provider "aws" {
  version = "2.62.0"
  region  = var.aws_region
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  versioning {
    enabled    = var.versioning.enabled
    mfa_delete = var.versioning.mfa_delete
  }

  dynamic "logging" {
    for_each = var.logging != null ? [var.logging] : []
    content {
      target_bucket = logging.value.target_bucket
      target_prefix = logging.value.target_prefix
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.server_side_encryption_configuration != null ? [var.server_side_encryption_configuration] : []
    iterator = ssec
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = ssec.value.sse_algorithm
          kms_master_key_id = ssec.value.sse_algorithm == "aws:kms" ? null : ssec.value.kms_master_key_id
        }
      }
    }
  }


  tags = merge({
    Name        = var.bucket_name
    Environment = var.environment
  }, var.tags)
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

}
