resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "aws_lambda_policy" {
  policy = var.function_policy
}

resource "aws_iam_policy_attachment" "aws_lambda_policy_attachment" {
  name = "aws_policy_attachment"
  roles = [aws_iam_role.iam_for_lambda.name]
  policy_arn = aws_iam_policy.aws_lambda_policy.arn
}

resource "aws_lambda_function" "test_lambda" {
  function_name = var.function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.function_handler

  s3_bucket = var.deployment_s3_location.s3_bucket
  s3_key = var.deployment_s3_location.s3_key
  s3_object_version = var.deployment_s3_location.s3_object_version

  runtime = var.function_runtime
  memory_size = var.function_memory_size

  environment {
    variables = var.function_env
  }

  vpc_config {
    security_group_ids = var.function_vpc_config.security_group_ids
    subnet_ids = var.function_vpc_config.subnet_ids
  }
}