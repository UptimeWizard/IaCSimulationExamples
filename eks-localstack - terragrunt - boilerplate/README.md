# EKS LocalStack – Terragrunt Cookiecutter Boilerplate

Cookiecutter template za brzo generisanje EKS Kubernetes klastera definisanog kroz Terraform module (network, iam, eks), upravljanog Terragruntom i deployovanog na LocalStack.

---

## Sadržaj

- [Preduslovi](#preduslovi)
- [Struktura repozitorijuma](#struktura-repozitorijuma)
- [Brzi start (Cookiecutter)](#brzi-start-cookiecutter)
- [Cookiecutter varijable](#cookiecutter-varijable)
- [Struktura generisanog projekta](#struktura-generisanog-projekta)
- [Pokretanje infrastrukture](#pokretanje-infrastrukture)
- [Provjera resursa](#provjera-resursa)
- [Uklanjanje resursa](#uklanjanje-resursa)
- [Bez Cookiecutter-a](#bez-cookiecutter-a)

---

## Preduslovi

| Alat | Minimalna verzija | Instalacija |
|---|---|---|
| Python | 3.8+ | [python.org](https://www.python.org/downloads/) |
| Cookiecutter | 2.1+ | `pip install cookiecutter` |
| Terraform | 1.0+ | [developer.hashicorp.com/terraform/install](https://developer.hashicorp.com/terraform/install) |
| Terragrunt | 0.50+ | [terragrunt.gruntwork.io](https://terragrunt.gruntwork.io/docs/getting-started/install/) |
| LocalStack CLI | 3.0+ | `pip install localstack` |
| AWS CLI | 2.x | [aws.amazon.com/cli](https://aws.amazon.com/cli/) |
| Docker Desktop | latest | [docker.com](https://www.docker.com/products/docker-desktop/) |

---

## Struktura repozitorijuma

```
eks-localstack - terragrunt - boilerplate/
├── cookiecutter.json                   # Cookiecutter konfiguracija i defaulti
├── hooks/
│   ├── pre_gen_project.py              # Validacija parametara prije generisanja
│   └── post_gen_project.py             # Post-generacijski setup i provjera alata
└── {{cookiecutter.project_slug}}/      # Template direktorijum
    ├── .gitignore
    ├── root.hcl                        # Root Terragrunt konfiguracija (provider)
    ├── terraform/                      # Root Terraform modul
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── modules/
    │       ├── network/                # VPC, subneti, security grupe
    │       ├── iam/                    # IAM uloge i politike
    │       └── eks/                    # EKS klaster i node group
    └── terragrunt/
        ├── dev/
        │   └── terragrunt.hcl          # Dev vrijednosti
        └── prod/
            └── terragrunt.hcl          # Prod vrijednosti
```

---

## Brzi start (Cookiecutter)

### 1. Instaliraj pip

Provjeri da li već imaš pip:

```bash
pip3 --version
```

Ako nije instaliran, instaliraj ga:

```bash
# Opcija 1 – Python ugrađeni alat
python3 -m ensurepip --upgrade

# Opcija 2 – Homebrew (preporučeno na macOS)
brew install python

# Opcija 3 – Ručna instalacija
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
```

### 2. Instaliraj Cookiecutter

```bash
pip install cookiecutter
```

> **Napomena za macOS:** pip instalira `cookiecutter` u `/Users/<korisnik>/Library/Python/3.9/bin`, koji često nije na PATH-u. Ako dobiješ grešku `command not found`, dodaj taj direktorijum u PATH:
>
> ```bash
> export PATH="$HOME/Library/Python/3.9/bin:$PATH"
> ```
>
> Da bi promjena bila trajna, dodaj je u `~/.zshrc`:
>
> ```bash
> echo 'export PATH="$HOME/Library/Python/3.9/bin:$PATH"' >> ~/.zshrc
> source ~/.zshrc
> ```

### 2. Generiši projekat

Lokalno (iz ovog repozitorijuma):

```bash
cookiecutter "eks-localstack - terragrunt - boilerplate"
```

Ili sa GitHub-a:

```bash
cookiecutter https://github.com/<tvoj-username>/eks-localstack-terragrunt-boilerplate
```

### 3. Odgovori na pitanja

Cookiecutter će te provesti kroz interaktivni wizard. Možeš pritisnuti `Enter` da prihvatiš defaultne vrijednosti:

```
project_name [eks-localstack]: moj-eks-projekat
project_slug [moj-eks-projekat]:
author [Your Name]: Miso Stamenic
description [EKS Kubernetes klaster...]:
aws_region [us-east-1]:
localstack_endpoint [http://localhost:4566]:
cluster_name [moj-eks-projekat-cluster]:
kubernetes_version [1.30]:
Select instance_type:
1 - t3.medium
2 - t3.small
3 - t3.large
4 - t3a.medium
Choose from 1, 2, 3, 4 [1]:
dev_vpc_cidr [10.0.0.0/16]:
...
```

> **Pre-generation hook** automatski validira sve parametre (CIDR opsezi, node scaling vrijednosti, AWS region format, project slug format) i zaustavlja generisanje ako nešto nije u redu.

### 4. Rezultat

Nakon što Cookiecutter završi, u trenutnom direktorijumu će biti kreiran folder `moj-eks-projekat/` (tvoj project_slug) sa kompletnom infrastrukturnom strukturom, spreman za `terragrunt init`.

**Post-generation hook** automatski:
- Prikazuje sažetak konfiguracije
- Provjerava da li su terraform, terragrunt i aws CLI instalirani
- Kreira `.terraform.lock.hcl` placeholder fajlove u dev/ i prod/
- Ispisuje naredne korake

---

## Cookiecutter varijable

| Varijabla | Default | Opis |
|---|---|---|
| `project_name` | `eks-localstack` | Naziv projekta (human-readable) |
| `project_slug` | *(iz project_name)* | Naziv direktorijuma (mala slova, crtice) |
| `author` | `Your Name` | Ime autora projekta |
| `description` | *(automatski)* | Kratki opis projekta |
| `aws_region` | `us-east-1` | AWS region za LocalStack |
| `localstack_endpoint` | `http://localhost:4566` | LocalStack URL |
| `cluster_name` | *(iz project_slug)* | Bazni naziv EKS klastera |
| `kubernetes_version` | `1.30` | Verzija Kubernetes-a na EKS klasteru |
| `instance_type` | `t3.medium` | EC2 tip instance za worker čvorove |
| `terraform_version` | `>= 1.0` | Minimalna verzija Terraform-a |
| `aws_provider_version` | `~> 5.0` | Verzija AWS Terraform provajdera |
| `dev_vpc_cidr` | `10.0.0.0/16` | VPC CIDR za dev okruženje |
| `dev_public_subnet_cidr` | `10.0.1.0/24` | Javni subnet CIDR za dev |
| `dev_private_subnet_cidr` | `10.0.2.0/24` | Privatni subnet CIDR za dev |
| `dev_node_desired` | `1` | Željeni broj čvorova u dev-u |
| `dev_node_min` | `1` | Minimalan broj čvorova u dev-u |
| `dev_node_max` | `2` | Maksimalan broj čvorova u dev-u |
| `prod_vpc_cidr` | `10.1.0.0/16` | VPC CIDR za prod okruženje |
| `prod_public_subnet_cidr` | `10.1.1.0/24` | Javni subnet CIDR za prod |
| `prod_private_subnet_cidr` | `10.1.2.0/24` | Privatni subnet CIDR za prod |
| `prod_node_desired` | `2` | Željeni broj čvorova u prod-u |
| `prod_node_min` | `2` | Minimalan broj čvorova u prod-u |
| `prod_node_max` | `5` | Maksimalan broj čvorova u prod-u |

---

## Struktura generisanog projekta

Nakon generisanja, tvoj projekat izgleda ovako (npr. za `project_slug = moj-eks`):

```
moj-eks/
├── .gitignore
├── root.hcl                            # Provider konfiguracija za LocalStack
├── terraform/
│   ├── main.tf                         # Poziva module: iam, network, eks
│   ├── variables.tf                    # Sve varijable sa tvojim defaultima
│   ├── outputs.tf                      # Outputi: cluster endpoint, VPC ID, ARN-ovi...
│   └── modules/
│       ├── network/
│       │   ├── main.tf                 # VPC, subneti, IGW, route table, security grupe
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── iam/
│       │   ├── main.tf                 # IAM uloge za klaster i worker čvorove
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── eks/
│           ├── main.tf                 # EKS klaster i node group
│           ├── variables.tf
│           └── outputs.tf
└── terragrunt/
    ├── dev/
    │   ├── .terraform.lock.hcl
    │   └── terragrunt.hcl              # Dev: 1-2 čvora, 10.0.x.x CIDR
    └── prod/
        ├── .terraform.lock.hcl
        └── terragrunt.hcl              # Prod: 2-5 čvorova, 10.1.x.x CIDR
```

---

## Pokretanje infrastrukture

### 1. Pokretanje LocalStack-a

```bash
# Pokreni Docker Desktop, zatim LocalStack
lstk start
```

### 2. Inicijalizacija i deploy

> Prije `init` ukloni stari `.terragrunt-cache` ako postoji:
> ```bash
> rm -rf terragrunt/dev/.terragrunt-cache
> rm -rf terragrunt/prod/.terragrunt-cache
> ```

**Dev okruženje:**

```bash
cd terragrunt/dev
terragrunt init
terragrunt plan
terragrunt apply
```

**Prod okruženje:**

```bash
cd terragrunt/prod
terragrunt init
terragrunt plan
terragrunt apply
```

---

## Provjera resursa

```bash
# Lista svih EKS klastera
aws --endpoint-url=http://localhost:4566 eks list-clusters
```

**Dev klaster (`dev-<cluster_name>`):**

```bash
aws --endpoint-url=http://localhost:4566 eks describe-cluster \
    --name dev-<cluster_name>

aws --endpoint-url=http://localhost:4566 eks list-nodegroups \
    --cluster-name dev-<cluster_name>

aws --endpoint-url=http://localhost:4566 eks describe-nodegroup \
    --cluster-name dev-<cluster_name> \
    --nodegroup-name dev-<cluster_name>-node-group
```

**Prod klaster (`prod-<cluster_name>`):**

```bash
aws --endpoint-url=http://localhost:4566 eks describe-cluster \
    --name prod-<cluster_name>

aws --endpoint-url=http://localhost:4566 eks list-nodegroups \
    --cluster-name prod-<cluster_name>
```

**Ostali resursi:**

```bash
# VPC mreže
aws --endpoint-url=http://localhost:4566 ec2 describe-vpcs

# Subneti
aws --endpoint-url=http://localhost:4566 ec2 describe-subnets

# IAM uloge
aws --endpoint-url=http://localhost:4566 iam list-roles
```

Ili pregled na LocalStack portalu: https://app.localstack.cloud/inst/default/overview

---

## Uklanjanje resursa

```bash
# Dev
cd terragrunt/dev
terragrunt destroy

# Prod
cd terragrunt/prod
terragrunt destroy

# Potvrda
aws --endpoint-url=http://localhost:4566 eks list-clusters
```

---

## Bez Cookiecutter-a

Ako ne želiš koristiti Cookiecutter, možeš direktno kopirati `{{cookiecutter.project_slug}}/` direktorijum i ručno zamijeniti `{{ cookiecutter.* }}` placeholder-e u svim fajlovima.

Ključne vrijednosti za zamjenu:

```
{{ cookiecutter.project_name }}    → naziv projekta
{{ cookiecutter.project_slug }}    → slug (direktorijum)
{{ cookiecutter.author }}          → ime autora
{{ cookiecutter.aws_region }}      → AWS region (npr. us-east-1)
{{ cookiecutter.localstack_endpoint }} → http://localhost:4566
{{ cookiecutter.cluster_name }}    → naziv EKS klastera
{{ cookiecutter.kubernetes_version }} → verzija K8s (npr. 1.30)
{{ cookiecutter.instance_type }}   → tip instance (npr. t3.medium)
{{ cookiecutter.terraform_version }} → >= 1.0
{{ cookiecutter.aws_provider_version }} → ~> 5.0
```

---

## Licenca

MIT
