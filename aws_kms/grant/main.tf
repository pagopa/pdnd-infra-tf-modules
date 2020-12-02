resource "aws_kms_grant" "this" {
  name              = var.name
  key_id            = var.key_id
  grantee_principal = var.role_arn
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]

}