output "arn" {
  value = aws_kms_key.this.arn
}
output "is_enabled" {
  value = aws_kms_key.this.is_enabled
}

output "id" {
  value = aws_kms_key.this.id
}