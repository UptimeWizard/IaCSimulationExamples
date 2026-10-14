# ============================================================
# ROOT terragrunt.hcl
# Zajednička konfiguracija za sva okruženja
# Projekat: {{ cookiecutter.project_name }}
# Autor:    {{ cookiecutter.author }}
# ============================================================

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = "{{ cookiecutter.terraform_version }}"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "{{ cookiecutter.aws_provider_version }}"
    }
  }
}

provider "aws" {
  region                      = "{{ cookiecutter.aws_region }}"
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "{{ cookiecutter.localstack_endpoint }}"
    eks = "{{ cookiecutter.localstack_endpoint }}"
    iam = "{{ cookiecutter.localstack_endpoint }}"
    s3  = "{{ cookiecutter.localstack_endpoint }}"
  }
}
EOF
}
