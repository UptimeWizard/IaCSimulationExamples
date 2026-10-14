# ============================================================
# DEV okruženje
# ============================================================

# Nasljeđuje root terragrunt.hcl (provider konfiguracija)
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Putanja do terraform root modula
terraform {
  source = "../../terraform"
}

# Vrednosti specifične za dev
inputs = {
  environment = "dev"
  aws_region  = "us-east-1"

  cluster_name        = "dev-eks-cluster"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"

  # Manji klaster za dev — štedi resurse
  node_group_desired_size = 1
  node_group_min_size     = 1
  node_group_max_size     = 2
}
