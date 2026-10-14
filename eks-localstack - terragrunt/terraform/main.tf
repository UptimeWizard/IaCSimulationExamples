module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
  environment  = var.environment
}

module "network" {
  source              = "./modules/network"
  cluster_name        = var.cluster_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  aws_region          = var.aws_region
  environment         = var.environment
}

module "eks" {
  source               = "./modules/eks"
  cluster_name         = var.cluster_name
  environment          = var.environment
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_role_arn    = module.iam.eks_node_role_arn
  public_subnet_id     = module.network.public_subnet_id
  private_subnet_id    = module.network.private_subnet_id
  eks_cluster_sg_id    = module.network.eks_cluster_sg_id

  node_group_desired_size = var.node_group_desired_size
  node_group_max_size     = var.node_group_max_size
  node_group_min_size     = var.node_group_min_size
}
