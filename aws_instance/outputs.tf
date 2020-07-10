output "id" {
  description = "Instance id"
  value       = aws_instance.this.id
}

output "arn" {
  description = "Instance ARN"
  value       = aws_instance.this.arn
}


output "public_dn" {
  description = "Public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.this.*.public_dns
}

output "public_ip" {
  description = "Public IP addresses assigned to the instance."
  value       = aws_instance.this.public_ip
}

output "primary_network_interface_id" {
  description = "ID of the primary network interface of instance"
  value       = aws_instance.this.primary_network_interface_id
}

output "private_dn" {
  description = "Private DNS name assigned to the instance."
  value       = aws_instance.this.private_dns
}

output "private_ip" {
  description = "Private IP addresses assigned to the instance"
  value       = aws_instance.this.private_ip
}

output "security_groups" {
  description = "Security groups of the instance"
  value       = aws_instance.this.security_groups
}

output "vpc_security_group_ids" {
  description = "Security groups of the instance"
  value       = aws_instance.this.vpc_security_group_ids
}

output "subnet_id" {
  description = "VPC subnet id"
  value       = aws_instance.this.subnet_id
}
