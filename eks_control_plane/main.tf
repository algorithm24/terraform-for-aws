resource "aws_eks_cluster" "eks-control-plane" {
  name     = "${var.env}-eks-control-plane"
  role_arn = aws_iam_role.eks-control-plane.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks-control-plane.id]
    subnet_ids         = var.vpc_zone_identifier
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-control-plane-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-control-plane-AmazonEKSServicePolicy,
  ]
}