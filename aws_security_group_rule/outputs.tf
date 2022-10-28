output "ids" {
    value = ["${aws_security_group_rule.this.*.id}"]
}