module "key" {
  source   = "./keypair"
  key_file = file("/Users/dyle/Desktop/terraform-for-aws/key_file/mykey.pub")
  env      = "bastion"
}
module "secret" {
  source = "./secret"
  length = 16
  env    = "all"
}
module "bastion-vpc" {
  source                     = "./vpc"
  vpc_cidr_block             = "10.3.0.0/16"
  env                        = "bastion"
  public_subnet_cidr_blocks  = ["10.3.0.0/24", "10.3.1.0/24", "10.3.2.0/24"]
  private_subnet_cidr_blocks = ["10.3.10.0/24", "10.3.11.0/24", "10.3.22.0/24"]
}
module "nonprod-vpc" {
  source                     = "./vpc"
  vpc_cidr_block             = "10.1.0.0/16"
  env                        = "nonprod"
  public_subnet_cidr_blocks  = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidr_blocks = ["10.1.10.0/24", "10.1.11.0/24", "10.1.22.0/24", "10.1.100.0/24", "10.1.110.0/24", "10.1.220.0/24"]
}
module "prod-vpc" {
  source                     = "./vpc"
  vpc_cidr_block             = "10.2.0.0/16"
  env                        = "prod"
  public_subnet_cidr_blocks  = ["10.2.0.0/24", "10.2.1.0/24", "10.2.2.0/24"]
  private_subnet_cidr_blocks = ["10.2.10.0/24", "10.2.11.0/24", "10.2.22.0/24", "10.2.100.0/24", "10.2.110.0/24", "10.2.220.0/24"]
}
module "eks-cluster" {
  source                      = "./eks_skeleton"
  env_prod                    = "prod"
  vpc_id_prod                 = module.prod-vpc.vpc_id
  vpc_zone_identifier_prod    = module.prod-vpc.subnet_ids_instance
  instance_type_prod          = "t2.medium"
  desired_capacity_prod       = 4
  env_nonprod                 = "nonprod"
  vpc_id_nonprod              = module.nonprod-vpc.vpc_id
  vpc_zone_identifier_nonprod = module.nonprod-vpc.subnet_ids_instance
  instance_type_nonprod       = "t2.medium"
  desired_capacity_nonprod    = 4
}
module "nonprod-rds" {
  source            = "./rds"
  env               = "nonprod"
  subnet_ids        = module.nonprod-vpc.subnet_ids_for_rds
  vpc_id            = module.nonprod-vpc.vpc_id
  username          = module.secret.db-creds.username
  password          = module.secret.db-creds.password
  cidr_block_access = module.nonprod-vpc.cidr_block_access_rds
  bastion_sg        = module.bastion-host.bastion-sg
}
module "prod-rds" {
  source            = "./rds"
  env               = "prod"
  subnet_ids        = module.prod-vpc.subnet_ids_for_rds
  vpc_id            = module.prod-vpc.vpc_id
  username          = module.secret.db-creds.username
  password          = module.secret.db-creds.password
  cidr_block_access = module.prod-vpc.cidr_block_access_rds
  bastion_sg        = module.bastion-host.bastion-sg
}
module "route-53" {
  source            = "./route53"
  nonprod_vpc_id    = module.nonprod-vpc.vpc_id
  prod_vpc_id       = module.prod-vpc.vpc_id
  rds_endpoint      = module.nonprod-rds.endpoint
  rds_endpoint_prod = module.prod-rds.endpoint
}
module "bastion-elb" {
  source  = "./elb"
  env     = "bastion"
  subnets = module.bastion-vpc.subnet_ids_elb
  vpc_id  = module.bastion-vpc.vpc_id
}
module "bastion-host" {
  source              = "./bastion_autoscaling"
  key_name            = module.key.key_name
  instance_type       = "t2.medium"
  vpc_zone_identifier = module.bastion-vpc.subnet_ids_instance
  load_balancers      = [module.bastion-elb.elb_name, ]
  vpc_id              = module.bastion-vpc.vpc_id

  iam_role_node_arn                      = module.eks-cluster.iam_role_node_arn
  eks_cluster_endpoint                   = module.eks-cluster.eks_cluster_endpoint
  eks_cluster_certificate_authority_data = module.eks-cluster.eks_cluster_certificate_authority_data
  eks_cluster_name                       = module.eks-cluster.eks_cluster_name
  eks_cluster_arn                        = module.eks-cluster.eks_cluster_arn

  iam_role_node_arn_prod                      = module.eks-cluster.iam_role_node_arn_prod
  eks_cluster_endpoint_prod                   = module.eks-cluster.eks_cluster_endpoint_prod
  eks_cluster_certificate_authority_data_prod = module.eks-cluster.eks_cluster_certificate_authority_data_prod
  eks_cluster_name_prod                       = module.eks-cluster.eks_cluster_name_prod
  eks_cluster_arn_prod                        = module.eks-cluster.eks_cluster_arn_prod

  external_dns_iam_role_arn = module.route-53.external-dns-iam-role-arn
  aws_access_key_id         = local.access_key
  aws_secret_access_key     = local.secret_key
}
module "bastion-nonprod" {
  source      = "./peering"
  peer_vpc_id = module.bastion-vpc.vpc_id
  vpc_id      = module.nonprod-vpc.vpc_id
}
module "bastion-prod" {
  source      = "./peering"
  peer_vpc_id = module.bastion-vpc.vpc_id
  vpc_id      = module.prod-vpc.vpc_id
}