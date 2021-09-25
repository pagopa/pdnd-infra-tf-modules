data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "tls_certificate" "certificate" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.certificate.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}