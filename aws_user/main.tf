resource "aws_iam_user" "this" {
  name = var.name
}

resource "aws_iam_user_policy" "this" {

  name = "${aws_iam_user.this.name}-policy"
  user = aws_iam_user.this.name

  policy = var.policy
}


resource "aws_iam_access_key" "this" {
  user    = aws_iam_user.this.name
}