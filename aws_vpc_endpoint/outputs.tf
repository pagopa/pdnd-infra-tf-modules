output "id" {
    value = aws_vpc_endpoint.this.id
}

output "type" {
    value = aws_vpc_endpoint.this.vpc_endpoint_type
}

output "route_table_ids" {
    value = aws_vpc_endpoint.this.route_table_ids
}

output "service" {
    value = aws_vpc_endpoint.this.service_name
}