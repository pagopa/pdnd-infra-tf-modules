output "id" {
  value = aws_iam_role.this.id
}

output "arn" {
  value = aws_iam_role.this.arn
}

output "name" {
  value = aws_iam_role.this.name
}

output "instance_profile_name" {
  value       = var.instance_profile_name != null ? aws_iam_instance_profile.this[0].name : null
  description = "The name of the instance profile."
}
