provider "aws" {
  version = "2.62.0"
  region  = var.aws_region
}

resource "aws_iam_policy" "this" {
  name        = var.name
  path        = var.path
  description = var.description

  policy = var.policy
}
