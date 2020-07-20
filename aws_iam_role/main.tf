resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = var.assume_role_policy

  tags = merge({
    Name        = "${var.name}-${var.environment}-role"
    Environment = var.environment
  }, var.tags)
}

resource "aws_iam_instance_profile" "this" {
  count = var.instance_profile_name != null ? 1 : 0
  role  = aws_iam_role.this.name
  name  = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.policy_arn_attachments)
  role       = aws_iam_role.this.name
  policy_arn = element(var.policy_arn_attachments, count.index)
}
