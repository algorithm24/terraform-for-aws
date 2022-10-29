output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}
output "eks_cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}
output "eks_cluster_arn" {
  value = aws_eks_cluster.eks-cluster.arn
}
output "eks_cluster_name" {
  value = aws_eks_cluster.eks-cluster.name
}
output "iam_role_node_arn" {
  value = aws_iam_role.node.arn
}