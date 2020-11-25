resource "aws_iam_user" "this" {
  name = "ses-user"
}

resource "aws_iam_user_policy" "this" {
  name = "send-email-policy"
  user = aws_iam_user.this.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": "*"
        }
    ]
}
EOF
}


resource "aws_iam_access_key" "this" {
  user    = aws_iam_user.this.name
}