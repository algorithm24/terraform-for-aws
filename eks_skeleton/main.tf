module "eks_control_plane_nonprod" {
  source = "../eks_control_plane"
  env = var.env_nonprod
  vpc_id = var.vpc_id_nonprod
  vpc_zone_identifier = var.vpc_zone_identifier_nonprod
  eks_data_plane_security_group_id = module.eks_data_plane_nonprod.eks_data_plane_security_group_id
}
module "eks_data_plane_nonprod" {
  source = "../eks_data_plane"
  env = var.env_nonprod
  vpc_id = var.vpc_id_nonprod
  vpc_zone_identifier = var.vpc_zone_identifier_nonprod
  instance_type = var.instance_type_nonprod
  desired_capacity = var.desired_capacity_nonprod
  eks_control_plane_certificate_authority = module.eks_control_plane_nonprod.eks_control_plane_certificate_authority_data
  eks_control_plane_endpoint = module.eks_control_plane_nonprod.eks_control_plane_endpoint
  eks_control_plane_security_group_id = module.eks_control_plane_nonprod.eks_control_plane_security_group_id
  eks_control_plane_version =  module.eks_control_plane_nonprod.eks_control_plane_version
}

module "eks_control_plane_prod" {
  source = "../eks_control_plane"
  env = var.env_prod
  vpc_id = var.vpc_id_prod
  vpc_zone_identifier = var.vpc_zone_identifier_prod
  eks_data_plane_security_group_id = module.eks_data_plane_prod.eks_data_plane_security_group_id
}
module "eks_data_plane_prod" {
  source = "../eks_data_plane"
  env = var.env_prod
  vpc_id = var.vpc_id_prod
  vpc_zone_identifier = var.vpc_zone_identifier_prod
  instance_type = var.instance_type_prod
  desired_capacity = var.desired_capacity_prod
  eks_control_plane_certificate_authority = module.eks_control_plane_prod.eks_control_plane_certificate_authority_data
  eks_control_plane_endpoint = module.eks_control_plane_prod.eks_control_plane_endpoint
  eks_control_plane_security_group_id = module.eks_control_plane_prod.eks_control_plane_security_group_id
  eks_control_plane_version =  module.eks_control_plane_prod.eks_control_plane_version
}