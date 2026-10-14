#!/usr/bin/env python3
"""
Cookiecutter pre-generation hook za EKS LocalStack Terragrunt projekat.

Izvršava se PRIJE nego što Cookiecutter kreira fajlove.
Zadaci:
  1. Validacija CIDR opsega (dev i prod ne smiju se preklapati)
  2. Validacija da node_min <= node_desired <= node_max
  3. Validacija AWS regiona (format: xx-xxxx-N)
  4. Upozorenje ako projekt slug sadrži nedozvoljene znakove
"""

import re
import sys

# ── Boje za terminal izlaz ──────────────────────────────────────────────────
RED    = "\033[91m"
YELLOW = "\033[93m"
BOLD   = "\033[1m"
RESET  = "\033[0m"

# ── Vrijednosti iz cookiecutter.json ────────────────────────────────────────
PROJECT_SLUG       = "{{ cookiecutter.project_slug }}"
AWS_REGION         = "{{ cookiecutter.aws_region }}"

DEV_VPC_CIDR       = "{{ cookiecutter.dev_vpc_cidr }}"
PROD_VPC_CIDR      = "{{ cookiecutter.prod_vpc_cidr }}"

DEV_NODE_MIN       = int("{{ cookiecutter.dev_node_min }}")
DEV_NODE_DESIRED   = int("{{ cookiecutter.dev_node_desired }}")
DEV_NODE_MAX       = int("{{ cookiecutter.dev_node_max }}")

PROD_NODE_MIN      = int("{{ cookiecutter.prod_node_min }}")
PROD_NODE_DESIRED  = int("{{ cookiecutter.prod_node_desired }}")
PROD_NODE_MAX      = int("{{ cookiecutter.prod_node_max }}")


def error(msg: str) -> None:
    print(f"\n{BOLD}{RED}  GREŠKA: {msg}{RESET}\n")
    sys.exit(1)


def warn(msg: str) -> None:
    print(f"  {YELLOW}⚠  {msg}{RESET}")


def validate_slug() -> None:
    """Slug smije sadržavati samo mala slova, brojeve i crtica."""
    pattern = re.compile(r'^[a-z0-9][a-z0-9\-]*[a-z0-9]$')
    if not pattern.match(PROJECT_SLUG):
        error(
            f"project_slug '{PROJECT_SLUG}' nije validan. "
            "Koristite samo mala slova, brojeve i crtice (npr. 'moj-eks-projekat')."
        )


def validate_aws_region() -> None:
    """Osnovna provjera formata AWS regiona (npr. us-east-1, eu-central-1)."""
    pattern = re.compile(r'^[a-z]{2}-[a-z]+-\d$')
    if not pattern.match(AWS_REGION):
        error(
            f"aws_region '{AWS_REGION}' nije validan format. "
            "Primjer: us-east-1, eu-central-1, ap-southeast-2."
        )


def validate_cidr_no_overlap() -> None:
    """
    Provjerava da dev i prod VPC CIDR-ovi ne koriste isti oktet prefiks
    (npr. 10.0.x.x vs 10.1.x.x). Jednostavna provjera za lokalni razvoj.
    """
    if DEV_VPC_CIDR == PROD_VPC_CIDR:
        error(
            f"dev_vpc_cidr i prod_vpc_cidr su identični: '{DEV_VPC_CIDR}'. "
            "Koristite različite CIDR opsege za svako okruženje."
        )

    dev_prefix  = ".".join(DEV_VPC_CIDR.split(".")[:2])
    prod_prefix = ".".join(PROD_VPC_CIDR.split(".")[:2])

    if dev_prefix == prod_prefix:
        warn(
            f"Dev ({DEV_VPC_CIDR}) i prod ({PROD_VPC_CIDR}) CIDR dijele isti /16 prefiks "
            f"({dev_prefix}.x.x). Razmotri korišćenje potpuno odvojenih opsega u produkciji."
        )


def validate_node_scaling(env: str, min_: int, desired: int, max_: int) -> None:
    """min <= desired <= max."""
    if not (min_ <= desired <= max_):
        error(
            f"{env}: neispravna konfiguracija čvorova — "
            f"min={min_}, desired={desired}, max={max_}. "
            f"Mora biti: min ≤ desired ≤ max."
        )
    if min_ < 1:
        error(f"{env}: node_min mora biti ≥ 1 (trenutno: {min_}).")
    if max_ > 20:
        warn(f"{env}: node_max={max_} je veoma visok za lokalni LocalStack razvoj.")


def main() -> None:
    print(f"\n  Validacija Cookiecutter parametara...")

    validate_slug()
    validate_aws_region()
    validate_cidr_no_overlap()
    validate_node_scaling("dev",  DEV_NODE_MIN,  DEV_NODE_DESIRED,  DEV_NODE_MAX)
    validate_node_scaling("prod", PROD_NODE_MIN, PROD_NODE_DESIRED, PROD_NODE_MAX)

    print(f"  Svi parametri su validni. Generisanje projekta...\n")


if __name__ == "__main__":
    main()
