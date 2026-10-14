# ============================================================
# DEV okruženje — {{ cookiecutter.project_name }}
# ============================================================

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../terraform"
}

inputs = {
  environment = "dev"
  aws_region  = "{{ cookiecutter.aws_region }}"

  cluster_name        = "dev-{{ cookiecutter.cluster_name }}"
  vpc_cidr            = "{{ cookiecutter.dev_vpc_cidr }}"
  public_subnet_cidr  = "{{ cookiecutter.dev_public_subnet_cidr }}"
  private_subnet_cidr = "{{ cookiecutter.dev_private_subnet_cidr }}"

  # Manji klaster za dev — štedi resurse
  node_group_desired_size = {{ cookiecutter.dev_node_desired }}
  node_group_min_size     = {{ cookiecutter.dev_node_min }}
  node_group_max_size     = {{ cookiecutter.dev_node_max }}
}
