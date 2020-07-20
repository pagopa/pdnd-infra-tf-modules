provider "aws" {
  version = "2.62.0"
  region  = var.aws_region
}

resource "aws_lb_target_group_attachment" "this" {
  target_group_arn  = var.target_group_arn
  target_id         = var.target_id
  port              = var.port
  availability_zone = var.availability_zone
}
