resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file(var.public_key_path_openssh)
}

resource "aws_secretsmanager_secret" "this" {
  name = var.secret_name
}

locals {
  ssh_keys_secret_map = {
    pub_key = base64encode(file(var.public_key_path_openssh))
    priv_key = base64encode(file(var.private_key_path_openssh))
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(local.ssh_keys_secret_map)
}