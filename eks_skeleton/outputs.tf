output "eks_cluster_endpoint" {
  value = module.eks_control_plane_nonprod.eks_control_plane_endpoint
}
output "eks_cluster_certificate_authority_data" {
  value = module.eks_control_plane_nonprod.eks_control_plane_certificate_authority_data
}
output "eks_cluster_arn" {
  value = module.eks_control_plane_nonprod.eks_control_plane_arn
}
output "eks_cluster_name" {
  value = module.eks_control_plane_nonprod.eks_control_plane_name
}
output "iam_role_node_arn" {
  value = module.eks_data_plane_nonprod.iam_role_node_arn
}
output "eks_cluster_endpoint_prod" {
  value = module.eks_control_plane_prod.eks_control_plane_endpoint
}
output "eks_cluster_certificate_authority_data_prod" {
  value = module.eks_control_plane_prod.eks_control_plane_certificate_authority_data
}
output "eks_cluster_arn_prod" {
  value = module.eks_control_plane_prod.eks_control_plane_arn
}
output "eks_cluster_name_prod" {
  value = module.eks_control_plane_prod.eks_control_plane_name
}
output "iam_role_node_arn_prod" {
  value = module.eks_data_plane_prod.iam_role_node_arn
}