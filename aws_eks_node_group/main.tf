module "iam_role" {
  source = "git::git@github.com:pagopa/pdnd-infra-tf-modules.git//aws_iam_role?ref=v0.1.0"
  name   = var.iam_role_name != null ? var.iam_role_name : join("-", [var.cluster_name, "role"])

  environment = var.environment
  aws_region  = var.aws_region

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge({
    Name        = var.iam_role_name
    Environment = var.environment
  }, var.tags)
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = module.iam_role.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = module.iam_role.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = module.iam_role.name
}

resource "aws_launch_template" "eks_launch_template" {
  name          = "eks-8ebfc9ef-1fec-5cf7-9477-9cf2afe08c30"
  instance_type = "t3.2xlarge"
  image_id      = "ami-0c37e3f6cdf6a9007"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  key_name = var.ec2_ssh_key

  tags = {
    "eks:cluster-name"   = "${var.cluster_name}",
    "eks:nodegroup-name" = "${var.node_group_name}"
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = "true"
      volume_size           = 160
      volume_type           = "gp2"
    }
  }

  lifecycle {
    ignore_changes = [
      user_data,
      iam_instance_profile,
      network_interfaces
    ]
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = module.iam_role.arn
  subnet_ids      = var.subnet_ids
  disk_size       = var.disk_size
  instance_types  = var.instance_types

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  launch_template {
    name    = var.cluster_name
    version = aws_launch_template.eks_launch_template.latest_version
  }

  dynamic "remote_access" {
    for_each = var.ec2_ssh_key != null && var.ec2_ssh_key != "" ? ["true"] : []
    content {
      ec2_ssh_key = var.ec2_ssh_key
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.demo-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.demo-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.demo-node-AmazonEC2ContainerRegistryReadOnly,
  ]

  lifecycle {
    ignore_changes = [
      launch_template
    ]
  }

  tags = merge({
    Name        = var.node_group_name
    Environment = var.environment
  }, var.tags)
}
