# ============================================================
# ROOT terragrunt.hcl
# Zajednička konfiguracija za sva okruženja
# ============================================================

# Svako okruženje (dev/, prod/) nasljeđuje ovaj fajl
# i prosleđuje svoje inputs kao terraform varijable.

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    eks = "http://localhost:4566"
    iam = "http://localhost:4566"
    s3  = "http://localhost:4566"
  }
}
EOF
}
