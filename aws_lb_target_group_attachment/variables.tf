variable "aws_region" {
  type = string
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "target_group_arn" {
  type        = string
  description = "The ARN of the target group with which to register targets"
}

variable "target_id" {
  type        = string
  description = "The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container. If the target type is ip, specify an IP address. If the target type is lambda, specify the arn of lambda."
}

variable "port" {
  type        = number
  description = "The port on which targets receive traffic."
  default     = null
}

variable "availability_zone" {
  type        = string
  description = "The Availability Zone where the IP address of the target is to be registered. If the private ip address is outside of the VPC scope, this value must be set to 'all'."
  default     = null
}
