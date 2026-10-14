# ============================================================
# PROD okruženje — {{ cookiecutter.project_name }}
# ============================================================

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../terraform"
}

inputs = {
  environment = "prod"
  aws_region  = "{{ cookiecutter.aws_region }}"

  cluster_name        = "prod-{{ cookiecutter.cluster_name }}"
  vpc_cidr            = "{{ cookiecutter.prod_vpc_cidr }}"
  public_subnet_cidr  = "{{ cookiecutter.prod_public_subnet_cidr }}"
  private_subnet_cidr = "{{ cookiecutter.prod_private_subnet_cidr }}"

  # Veći klaster za prod — visoka dostupnost
  node_group_desired_size = {{ cookiecutter.prod_node_desired }}
  node_group_min_size     = {{ cookiecutter.prod_node_min }}
  node_group_max_size     = {{ cookiecutter.prod_node_max }}
}
