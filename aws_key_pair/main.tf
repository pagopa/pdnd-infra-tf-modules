provider "aws" {
  version = "2.62.0"
  region  = var.aws_region
}

data "aws_secretsmanager_secret" "this" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "this" {
  secret_id     = "${data.aws_secretsmanager_secret.this.id}"
  version_stage = var.version_stage

}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string)[var.secret_key_name]
}
