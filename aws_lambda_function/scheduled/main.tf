data "archive_file" "code" {
  type             = "zip"
  source_file      = var.source_file
  output_path      = "${path.module}/${var.function_name}.zip"
  output_file_mode = "0666"
}

resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  filename         = data.archive_file.code.output_path
  runtime          = var.runtime
  tags             = var.tags
  timeout          = var.timeout
  role             = var.role
  source_code_hash = data.archive_file.code.output_base64sha256
  handler          = var.handler
  memory_size      = var.memory_size
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
}
