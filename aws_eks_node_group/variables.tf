variable "aws_region" {
  type = string
}

variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "owner" {
  type        = string
  description = "The Owner tag"
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster."
}

variable "iam_role_name" {
  type        = string
  description = "The name of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags, each pair."
  default     = null
}

variable "kubernetes_master_version" {
  type        = string
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "The vpc id"
}

variable "node_group_name" {
  type        = string
  description = "Name of the EKS Node Group."
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes."
}

variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes."
}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes."
}
variable "disk_size" {
  type = number
  description = "Disk size"
  default = 20
}

variable "instance_types" {
  type = list(string)
  description = "EC2 size"
  default = ["t3.medium"]

}

variable "ec2_ssh_key" {
  type        = string
  description = "Name of the SSH key to be used to access nodes"
}