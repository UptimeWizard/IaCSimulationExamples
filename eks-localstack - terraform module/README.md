# EKS LocalStack – Terraform Module

EKS Kubernetes klaster definisan kroz Terraform module (network, iam, eks) i deployovan na LocalStack.

## Struktura projekta

```
eks-localstack - terraform module/
├── main.tf           # Root modul – poziva sve child module
├── variables.tf
├── outputs.tf
├── provider.tf
└── modules/
    ├── network/      # VPC, subneti, security grupe
    ├── iam/          # IAM uloge i politike
    └── eks/          # EKS klaster i node group
```

## Demo

### 1. Pokretanje okruženja

```bash
# Pokreni Docker Desktop, zatim LocalStack
lstk start
```

### 2. Inicijalizacija i deploy

> **Napomena:** Izvršeno na MacBook Air M3. Putanje su relativne — prilagodi `<path-to-repo>` svom lokalnom okruženju.

```bash
# Zamijeni <path-to-repo> sa stvarnom putanjom na tvom računaru, npr:
#   cd "$HOME/Projects/IaCSimulationExamples/eks-localstack - terraform module"
cd "<path-to-repo>/IaCSimulationExamples/eks-localstack - terraform module"

terraform init
terraform plan
terraform apply
```

### 3. Provjera resursa

```bash
# Lista klastera
aws --endpoint-url=http://localhost:4566 eks list-clusters

# Detalji klastera
aws --endpoint-url=http://localhost:4566 eks describe-cluster --name local-eks-cluster

# Lista node grupa
aws --endpoint-url=http://localhost:4566 eks list-nodegroups --cluster-name local-eks-cluster
```

Ili provjeri na LocalStack portalu: https://app.localstack.cloud/inst/default/overview

### 4. Uklanjanje resursa

```bash
terraform destroy

# Potvrdi da je klaster uklonjen
aws --endpoint-url=http://localhost:4566 eks list-clusters
```
