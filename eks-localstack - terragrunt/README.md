# EKS LocalStack – Terraform Module

EKS Kubernetes klaster definisan kroz Terraform module (network, iam, eks) i deployovan na LocalStack.

## Struktura projekta

```
eks-localstack - terragrunt/
├── root.hcl                        # Root Terragrunt konfiguracija (provider)
├── terraform/                      # Root Terraform modul
│   ├── main.tf                     # Poziva sve child module
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── network/                # VPC, subneti, security grupe
│       ├── iam/                    # IAM uloge i politike
│       └── eks/                    # EKS klaster i node group
└── terragrunt/                     # Terragrunt okruženja
    ├── dev/
    │   └── terragrunt.hcl          # Dev vrijednosti (1–2 noda, 10.0.x.x)
    └── prod/
        └── terragrunt.hcl          # Prod vrijednosti (2–5 nodova, 10.1.x.x)
```

## Demo

### 1. Pokretanje okruženja

```bash
# Pokreni Docker Desktop, zatim LocalStack
lstk start
```

### 2. Inicijalizacija i deploy

> **Napomena:** Izvršeno na MacBook Air M3. Putanje su relativne — prilagodi `<path-to-repo>` svom lokalnom okruženju.

> **Napomena:** Prije `init` provjeri i ukloni stari `.terragrunt-cache` ako postoji:
> ```bash
> # Dev
> [ -d "terragrunt/dev/.terragrunt-cache" ] && rm -rf "terragrunt/dev/.terragrunt-cache"
> 
> # Prod
> [ -d "terragrunt/prod/.terragrunt-cache" ] && rm -rf "terragrunt/prod/.terragrunt-cache"
> ```

**Dev okruženje:**
```bash
# Zamijeni <path-to-repo> sa stvarnom putanjom na tvom računaru, npr:
#   cd "$HOME/Projects/IaCSimulationExamples/eks-localstack - terragrunt/terragrunt/dev"
cd "<path-to-repo>/IaCSimulationExamples/eks-localstack - terragrunt/terragrunt/dev"
terragrunt init
terragrunt plan
terragrunt apply
```

**Prod okruženje:**
```bash
cd "<path-to-repo>/IaCSimulationExamples/eks-localstack - terragrunt/terragrunt/prod"
terragrunt init
terragrunt plan
terragrunt apply
```

### 3. Provjera resursa

```bash
# Lista svih klastera
aws --endpoint-url=http://localhost:4566 eks list-clusters
```

**Dev okruženje (`dev-eks-cluster`):**
```bash
# Detalji klastera
aws --endpoint-url=http://localhost:4566 eks describe-cluster --name dev-eks-cluster

# Lista node grupa
aws --endpoint-url=http://localhost:4566 eks list-nodegroups --cluster-name dev-eks-cluster

# Detalji node grupe
aws --endpoint-url=http://localhost:4566 eks describe-nodegroup --cluster-name dev-eks-cluster --nodegroup-name dev-eks-cluster-node-group
```

**Prod okruženje (`prod-eks-cluster`):**
```bash
# Detalji klastera
aws --endpoint-url=http://localhost:4566 eks describe-cluster --name prod-eks-cluster

# Lista node grupa
aws --endpoint-url=http://localhost:4566 eks list-nodegroups --cluster-name prod-eks-cluster

# Detalji node grupe
aws --endpoint-url=http://localhost:4566 eks describe-nodegroup --cluster-name prod-eks-cluster --nodegroup-name prod-eks-cluster-node-group
```

**Ostali resursi:**
```bash
# Lista VPC mreža
aws --endpoint-url=http://localhost:4566 ec2 describe-vpcs

# Lista subneta
aws --endpoint-url=http://localhost:4566 ec2 describe-subnets

# Lista IAM uloga
aws --endpoint-url=http://localhost:4566 iam list-roles
```

Ili provjeri na LocalStack portalu: https://app.localstack.cloud/inst/default/overview

### 4. Uklanjanje resursa

**Dev okruženje:**
```bash
cd "<path-to-repo>/IaCSimulationExamples/eks-localstack - terragrunt/terragrunt/dev"
terragrunt destroy
```

**Prod okruženje:**
```bash
cd "<path-to-repo>/IaCSimulationExamples/eks-localstack - terragrunt/terragrunt/prod"
terragrunt destroy
```

```bash
# Potvrdi da je klaster uklonjen
aws --endpoint-url=http://localhost:4566 eks list-clusters
```
