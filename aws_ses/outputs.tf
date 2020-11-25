output "aws_iam_user_name" {
  value = aws_iam_user.this.name
}

output "aws_iam_user_name_arn" {
  value = aws_iam_user.this.arn
}

output "aws_iam_smtp_user" {
  value = aws_iam_access_key.this.id
}

output "aws_iam_smtp_password" {
  value = aws_iam_access_key.this.ses_smtp_password_v4
}

output "aws_iam_access_key_id" {
  value = aws_iam_access_key.this.id
}

output "aws_iam_access_key" {
  value = aws_iam_access_key.this.secret
}