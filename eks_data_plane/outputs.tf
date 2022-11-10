output "iam_role_node_arn" {
  value = aws_iam_role.node.arn
}
output "eks_data_plane_security_group_id" {
  value = aws_security_group.node.id
}