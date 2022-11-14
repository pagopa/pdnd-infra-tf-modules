output "id" {
  value = aws_secretsmanager_secret.this.id
}

output "arn" {
  value = aws_secretsmanager_secret.this.arn
}

output "version_id" {
  value = aws_secretsmanager_secret_version.this.version_id
}

output "version_arn" {
  value = aws_secretsmanager_secret_version.this.arn
}

output "combined_id" {
  value = aws_secretsmanager_secret_version.this.id
}
