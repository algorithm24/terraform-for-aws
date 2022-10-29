variable "key_name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "vpc_zone_identifier" {
  type = list(string)
}
variable "load_balancers" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}
variable "iam_role_node_arn" {
  type = string
}
variable "eks_cluster_endpoint" {
  type = string
}
variable "eks_cluster_certificate_authority_data" {
  type = string
}
variable "eks_cluster_name" {
  type = string
}
variable "eks_cluster_arn" {
  type = string
}
variable "iam_role_node_arn_prod" {
  type = string
}
variable "eks_cluster_endpoint_prod" {
  type = string
}
variable "eks_cluster_certificate_authority_data_prod" {
  type = string
}
variable "eks_cluster_name_prod" {
  type = string
}
variable "eks_cluster_arn_prod" {
  type = string
}
variable "aws_access_key_id" {
  type = string
}
variable "aws_secret_access_key" {
  type = string
}
variable "external_dns_iam_role_arn" {
  type = string
}