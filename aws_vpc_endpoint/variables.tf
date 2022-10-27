variable "vpc_id" {
    type = string
    description = "The ID of the VPC."
}

variable "service" {
    type = string
    description = "The service the VPC Endpoint applies to."
}

variable "type" {
    type = string
    description = "The VPC Endpoint type [Gateway, Interface]."
}

variable "route_table_ids" {
    type = list(string)
    description = "The Route Tables ids the VPC Endpoint applies to (only for Gateway endpoints)."
}