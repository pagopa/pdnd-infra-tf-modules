resource "aws_security_group_rule" "this" {
  count                    = length(var.security_rules)
  type                     = var.security_rules[count.index].type
  from_port                = var.security_rules[count.index].from_port
  to_port                  = var.security_rules[count.index].to_port
  protocol                 = var.security_rules[count.index].protocol
  cidr_blocks              = var.security_rules[count.index].cidr_blocks
  security_group_id        = var.security_group_id
  description              = var.security_rules[count.index].description
  source_security_group_id = var.security_rules[count.index].source_security_group_id
  self                     = var.security_rules[count.index].self
  ipv6_cidr_blocks         = var.security_rules[count.index].ipv6_cidr_blocks
}