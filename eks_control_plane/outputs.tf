output "eks_control_plane_endpoint" {
  value = aws_eks_cluster.eks-control-plane.endpoint
}
output "eks_control_plane_certificate_authority_data" {
  value = aws_eks_cluster.eks-control-plane.certificate_authority[0].data
}
output "eks_control_plane_arn" {
  value = aws_eks_cluster.eks-control-plane.arn
}
output "eks_control_plane_name" {
  value = aws_eks_cluster.eks-control-plane.name
}
output "eks_control_plane_version" {
  value = aws_eks_cluster.eks-control-plane.version
}
output "eks_control_plane_security_group_id" {
  value = aws_security_group.eks-control-plane.id
}