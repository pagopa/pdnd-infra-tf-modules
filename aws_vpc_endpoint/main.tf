data "aws_vpc_endpoint_service" "service" {
    service = var.service
    service_type = var.type
    route_table_ids = var.route_table_ids
}

resource "aws_vpc_endpoint" "this" {
    vpc_id = var.vpc_id
    service_name = data.aws_vpc_endpoint_service.service.service_name
    vpc_endpoint_type = var.type
}

resource "aws_vpc_endpoint_policy" "policy" {
    vpc_endpoint_id = aws_vpc_endpoint.this.id
    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "AllowAll",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "*"
                },
                "Action": [
                    "${var.service}:*"
                ],
                "Resource": "*"
            }
        ]
    })
}