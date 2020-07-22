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
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    Name        = var.iam_role_name
    Environment = var.environment
    Owner       = var.owner
  }


}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = module.iam_role.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = module.iam_role.name
}

#EKS Service
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = module.iam_role.arn

  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }

  version = var.kubernetes_master_version

  tags = merge({
    Name        = var.cluster_name
    Environment = var.environment
  }, var.tags)

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
  ]
}
