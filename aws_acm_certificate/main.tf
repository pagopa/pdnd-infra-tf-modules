resource "tls_private_key" "this" {
  count     = var.self_signed == true ? 1 : 0
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "this" {
  count           = var.self_signed == true ? 1 : 0
  key_algorithm   = "RSA"
  private_key_pem = var.self_signed == true ? tls_private_key.this[0].private_key_pem : null

  subject {
    common_name  = var.common_name
    organization = var.organization
  }

  validity_period_hours = var.validity_period_hours

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = var.validation_method

  private_key      = var.self_signed == true ? tls_private_key.this[0].private_key_pem : null
  certificate_body = var.self_signed == true ? tls_self_signed_cert.this[0].cert_pem : null

  tags = merge({
    Name        = var.self_signed == true ? var.common_name : var.domain_name
    Environment = var.environment
  }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}
