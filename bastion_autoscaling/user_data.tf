data "template_file" "config-file" {
  template = file("/Users/dyle/Desktop/terraform-for-aws/user_data_file/config")
  vars = {
    eks_cluster_endpoint = var.eks_cluster_endpoint
    eks_cluster_certificate_authority_data = var.eks_cluster_certificate_authority_data
    eks_cluster_name = var.eks_cluster_name
    eks_cluster_arn = var.eks_cluster_arn
    eks_cluster_endpoint_prod = var.eks_cluster_endpoint_prod
    eks_cluster_certificate_authority_data_prod = var.eks_cluster_certificate_authority_data_prod
    eks_cluster_name_prod = var.eks_cluster_name_prod
    eks_cluster_arn_prod = var.eks_cluster_arn_prod
  }
}
data "template_file" "auth-file" {
  template = file("/Users/dyle/Desktop/terraform-for-aws/user_data_file/auth.yaml")
  vars = {
    iam_role_node_arn = var.iam_role_node_arn
  }
}
data "template_file" "auth-file-prod" {
  template = file("/Users/dyle/Desktop/terraform-for-aws/user_data_file/auth.yaml")
  vars = {
    iam_role_node_arn = var.iam_role_node_arn_prod
  }
}
data "template_file" "aws-auth-file" {
  template = file("/Users/dyle/Desktop/terraform-for-aws/user_data_file/aws-auth.sh")
  vars = {
    aws_access_key_id = var.aws_access_key_id
    aws_secret_access_key = var.aws_secret_access_key
  }
}
data "template_file" "service-account" {
  template = file("/Users/dyle/Desktop/terraform-for-aws/user_data_file/service-account.yaml")
  vars = {
    external_dns_iam_role_arn = var.external_dns_iam_role_arn
  }
}
data "template_file" "user-data" {
  template = file("/Users/dyle/Desktop/terraform-for-aws/user_data_file/userdata_for_bastion.sh")
  vars = {
    config_file = data.template_file.config-file.rendered
    auth_file = data.template_file.auth-file.rendered
    auth_file_prod = data.template_file.auth-file-prod.rendered
    script_file = file("/Users/dyle/Desktop/terraform-for-aws/user_data_file/script.sh")
    aws_auth_file = data.template_file.aws-auth-file.rendered
    service_account_file = data.template_file.service-account.rendered
  }
}