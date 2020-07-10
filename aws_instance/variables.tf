variable "aws_region" {
  type = string
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "ami" {
  description = "he AMI to use for the instance."
  type        = string
}

variable "placement_group" {
  description = "The Placement Group to start the instance in."
  type        = string
  default     = ""
}


variable "tenancy" {
  description = " The tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported for the import-instance command."
  type        = string
  default     = "default"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "key_name" {
  type        = string
  description = "The key name to use for the instance"
  default     = ""
}

variable "monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled."
  default     = false
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with."
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "The VPC Subnet ID to launch in."
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC Subnet IDs to launch in"
  default     = []
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public ip address with an instance in a VPC."
  default     = false
}

variable "private_ip" {
  type        = string
  description = "Private IP address to associate with the instance in a VPC."
  default     = null
}

variable "private_ips" {
  type        = list(string)
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  default     = []
}

variable "source_dest_check" {
  type        = bool
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  default     = true
}

variable "user_data" {
  type        = string
  default     = null
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  type        = string
  default     = ""
}

variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  type        = number
  default     = null
}

variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = null
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(map(string))
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  type        = list(map(string))
  default     = []
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = "standard"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}
