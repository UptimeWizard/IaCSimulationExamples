# ============================================================
# PROD okruženje
# ============================================================

# Nasljeđuje root terragrunt.hcl (provider konfiguracija)
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Putanja do terraform root modula
terraform {
  source = "../../terraform"
}

# Vrednosti specifične za prod
inputs = {
  environment = "prod"
  aws_region  = "us-east-1"

  cluster_name        = "prod-eks-cluster"
  vpc_cidr            = "10.1.0.0/16"
  public_subnet_cidr  = "10.1.1.0/24"
  private_subnet_cidr = "10.1.2.0/24"

  # Veći klaster za prod — visoka dostupnost
  node_group_desired_size = 2
  node_group_min_size     = 2
  node_group_max_size     = 5
}
