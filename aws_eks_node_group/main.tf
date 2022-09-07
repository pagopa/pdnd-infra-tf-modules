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

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = module.iam_role.arn
  subnet_ids      = var.subnet_ids
  disk_size = var.disk_size
  instance_types = var.instance_types

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  dynamic "remote_access" {
    for_each = var.ec2_ssh_key != null && var.ec2_ssh_key != "" ? ["true"] : []
    content {
      ec2_ssh_key               = var.ec2_ssh_key
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.demo-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.demo-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.demo-node-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = merge({
    Name        = var.node_group_name
    Environment = var.environment
  }, var.tags)
}

resource "aws_autoscaling_schedule" "shutdown" {
  count                  = length(aws_eks_node_group.this.resources)
  scheduled_action_name  = "scheduled-shutdown"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  autoscaling_group_name = aws_eks_node_group.this.resources[count.index].autoscaling_groups[0].name
  recurrence             = var.shutdown_time
  timezone               = "Etc/UTC"
}

resource "aws_autoscaling_schedule" "spinup" {
  count                  = length(aws_eks_node_group.this.resources)
  scheduled_action_name  = "scheduled-spinup"
  min_size               = var.mix_size
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  autoscaling_group_name = aws_eks_node_group.this.resources[count.index].autoscaling_groups[0].name
  recurrence             = var.spinup_time
  timezone               = "Etc/UTC"
}