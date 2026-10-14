# EKS LocalStack – Terraform

EKS Kubernetes klaster deployovan pomoću Terraforma u lokalnom AWS okruženju simuliranom kroz LocalStack.

## Struktura projekta

```
eks-localstack - terraform/
├── provider.tf    # AWS provajder konfigurisan za LocalStack
├── variables.tf   # Ulazne varijable
├── network.tf     # VPC, subneti, security grupe
├── iam.tf         # IAM uloge i politike
├── eks.tf         # EKS klaster i node group
└── outputs.tf     # Izlazne vrijednosti
```

## Preduslovi

- Terraform >= 1.0
- Docker Desktop
- LocalStack
- AWS CLI (za provjeru resursa)

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
#   cd "$HOME/Projects/IaCSimulationExamples/eks-localstack - terraform"
cd "<path-to-repo>/IaCSimulationExamples/eks-localstack - terraform"

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

### 4. Izlazne vrijednosti

```bash
terraform output
```

### 5. Uklanjanje resursa

```bash
terraform destroy
```

## Konfiguracija

Varijable se mogu prilagoditi u `variables.tf` ili kroz `.tfvars` fajl:

```hcl
aws_region              = "us-east-1"
cluster_name            = "local-eks-cluster"
vpc_cidr                = "10.0.0.0/16"
node_group_desired_size = 1
environment             = "dev"
```

## Arhitektura resursa

| Kategorija | Resursi |
|---|---|
| Mreža | VPC, javni i privatni subnet, Internet Gateway, route table |
| Bezbjednost | Security grupe za klaster i čvorove, IAM uloge |
| EKS | Upravljani klaster, node group (t3.medium) |

## Ograničenja LocalStack-a

- EKS nije u potpunosti emuliran — nema stvarnog Kubernetes backenda
- IAM politike se ne primjenjuju u punom obimu
- Performanse nisu reprezentativne za pravi AWS

## Dalji koraci

- Reorganizacija u Terraform module → [`eks-localstack - terraform module`](../eks-localstack%20-%20terraform%20module/)
- Udaljeni state backend (S3 + DynamoDB)
- Terragrunt za upravljanje više okruženja
- Deploy na pravi AWS

## Reference

- [Terraform dokumentacija](https://www.terraform.io/docs)
- [LocalStack dokumentacija](https://docs.localstack.cloud/)
- [AWS EKS dokumentacija](https://docs.aws.amazon.com/eks/)
