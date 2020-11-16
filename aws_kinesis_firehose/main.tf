resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.firehose_name
  destination = "extended_s3"

  server_side_encryption {
    enabled = var.firehose_server_side_encryption.enabled
  }

  extended_s3_configuration {

    role_arn   = aws_iam_role.firehose_role.arn

    bucket_arn = var.firehose_extended_s3_configurations.bucket_arn
    prefix = var.firehose_extended_s3_configurations.prefix
    error_output_prefix = var.firehose_extended_s3_configurations.error_output_prefix
    buffer_size = var.firehose_extended_s3_configurations.buffer_size
    buffer_interval = var.firehose_extended_s3_configurations.buffer_interval

    cloudwatch_logging_options {
      enabled = var.firehose_extended_s3_configurations.cloudwatch_enabled
      log_group_name = var.firehose_extended_s3_configurations.cloudwatch_log_group
      log_stream_name = var.firehose_extended_s3_configurations.cloudwatch_log_stream_name
    }

  }
}


resource "aws_iam_policy" "aws_kinesis_firehose_policy" {
  policy = var.firehose_iam_policy
}

resource "aws_iam_policy_attachment" "aws_kinesis_firehose_policy-attachment" {
  name = "aws_kinesis_firehose_policy-attachment"
  roles = [aws_iam_role.firehose_role.name]
  policy_arn = aws_iam_policy.aws_kinesis_firehose_policy.arn
}

resource "aws_iam_role" "firehose_role" {
  name = "firehose_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "firehose_put_role_template" {
  statement {
    actions   = ["firehose:PutRecord","firehose:PutRecordBatch","firehose:UpdateDestination"]
    resources = [aws_kinesis_firehose_delivery_stream.this.arn]
  }
}

resource "aws_iam_policy" "this" {
  name = "${var.firehose_name}-put-policy"
  policy = data.aws_iam_policy_document.firehose_put_role_template.json
}