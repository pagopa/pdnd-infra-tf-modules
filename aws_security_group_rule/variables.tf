variable "security_rules" {
  type = list(object({
    type                     = string
    from_port                = number
    description              = string
    to_port                  = number
    protocol                 = string
    cidr_blocks              = list(string)
    source_security_group_id = string
    self                     = bool
    ipv6_cidr_blocks         = list(string)
  }))
  default = []
}

variable "security_group_id" {
    type = string
}
