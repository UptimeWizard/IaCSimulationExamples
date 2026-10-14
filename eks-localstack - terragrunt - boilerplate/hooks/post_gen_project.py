#!/usr/bin/env python3
"""
Cookiecutter post-generation hook za {{ cookiecutter.project_name }}.

Izvršava se automatski nakon što Cookiecutter kreira projekat.
Zadaci:
  1. Prikazuje sažetak generisanog projekta
  2. Provjerava da li su potrebni alati instalirani (terraform, terragrunt)
  3. Kreira .terraform.lock.hcl placeholder fajlove za dev i prod
  4. Ispisuje naredne korake za korisnika
"""

import os
import sys
import shutil
import subprocess

# ── Boje za terminal izlaz ──────────────────────────────────────────────────
GREEN  = "\033[92m"
YELLOW = "\033[93m"
RED    = "\033[91m"
CYAN   = "\033[96m"
BOLD   = "\033[1m"
RESET  = "\033[0m"

PROJECT_NAME       = "{{ cookiecutter.project_name }}"
PROJECT_SLUG       = "{{ cookiecutter.project_slug }}"
AUTHOR             = "{{ cookiecutter.author }}"
AWS_REGION         = "{{ cookiecutter.aws_region }}"
LOCALSTACK_ENDPOINT = "{{ cookiecutter.localstack_endpoint }}"
CLUSTER_NAME       = "{{ cookiecutter.cluster_name }}"
K8S_VERSION        = "{{ cookiecutter.kubernetes_version }}"
INSTANCE_TYPE      = "{{ cookiecutter.instance_type }}"


def print_header(text: str) -> None:
    print(f"\n{BOLD}{CYAN}{'=' * 60}{RESET}")
    print(f"{BOLD}{CYAN}  {text}{RESET}")
    print(f"{BOLD}{CYAN}{'=' * 60}{RESET}")


def print_ok(text: str) -> None:
    print(f"  {GREEN}✔{RESET}  {text}")


def print_warn(text: str) -> None:
    print(f"  {YELLOW}⚠{RESET}  {text}")


def print_err(text: str) -> None:
    print(f"  {RED}✘{RESET}  {text}")


def check_tool(name: str, version_flag: str = "--version") -> bool:
    """Provjerava da li je alat dostupan na PATH-u."""
    path = shutil.which(name)
    if path:
        try:
            result = subprocess.run(
                [name, version_flag],
                capture_output=True,
                text=True,
                timeout=5,
            )
            version_line = (result.stdout or result.stderr).splitlines()
            version_info = version_line[0].strip() if version_line else "?"
            print_ok(f"{name:12s} → {version_info}")
        except Exception:
            print_ok(f"{name:12s} → pronađen (verzija nepoznata)")
        return True
    else:
        print_warn(f"{name:12s} → NIJE pronađen na PATH-u")
        return False


def create_lock_placeholders() -> None:
    """
    Kreira prazne .terraform.lock.hcl placeholder fajlove u
    terragrunt/dev/ i terragrunt/prod/ kako bi Git pokupio direktorijume.
    """
    for env in ("dev", "prod"):
        lock_path = os.path.join("terragrunt", env, ".terraform.lock.hcl")
        if not os.path.exists(lock_path):
            with open(lock_path, "w") as f:
                f.write(
                    "# Ovaj fajl generiše Terraform/Terragrunt automatski.\n"
                    "# Ne edituj ručno.\n"
                )
            print_ok(f"Kreiran placeholder: {lock_path}")


def print_summary() -> None:
    print_header("Generisani projekat — sažetak")
    print(f"  {BOLD}Naziv:{RESET}              {PROJECT_NAME}")
    print(f"  {BOLD}Slug:{RESET}               {PROJECT_SLUG}")
    print(f"  {BOLD}Autor:{RESET}              {AUTHOR}")
    print(f"  {BOLD}AWS region:{RESET}         {AWS_REGION}")
    print(f"  {BOLD}LocalStack endpoint:{RESET} {LOCALSTACK_ENDPOINT}")
    print(f"  {BOLD}Cluster name:{RESET}       {CLUSTER_NAME}")
    print(f"  {BOLD}Kubernetes verzija:{RESET} {K8S_VERSION}")
    print(f"  {BOLD}Instance type:{RESET}      {INSTANCE_TYPE}")


def print_next_steps() -> None:
    print_header("Naredni koraci")
    steps = [
        ("1", "Pokreni LocalStack",
         "lstk start"),
        ("2", "Ukloni stari cache (ako postoji)",
         f'rm -rf terragrunt/dev/.terragrunt-cache\n'
         f'     rm -rf terragrunt/prod/.terragrunt-cache'),
        ("3", "Inicijalizuj i deploy dev okruženje",
         "cd terragrunt/dev && terragrunt init && terragrunt apply"),
        ("4", "Inicijalizuj i deploy prod okruženje",
         "cd terragrunt/prod && terragrunt init && terragrunt apply"),
        ("5", "Provjeri kreirane klastere",
         "aws --endpoint-url=http://localhost:4566 eks list-clusters"),
    ]
    for num, title, cmd in steps:
        print(f"\n  {BOLD}{CYAN}Korak {num}:{RESET} {title}")
        print(f"     {YELLOW}{cmd}{RESET}")


def main() -> None:
    print_summary()

    print_header("Provjera alata")
    terraform_ok  = check_tool("terraform")
    terragrunt_ok = check_tool("terragrunt")
    check_tool("aws")

    if not terraform_ok:
        print_warn("Instaliraj terraform:  https://developer.hashicorp.com/terraform/install")
    if not terragrunt_ok:
        print_warn("Instaliraj terragrunt: https://terragrunt.gruntwork.io/docs/getting-started/install/")

    print_header("Post-generacijski setup")
    create_lock_placeholders()

    print_next_steps()

    print(f"\n{BOLD}{GREEN}  Projekat '{PROJECT_SLUG}' uspješno generisan! 🚀{RESET}\n")

    # Izlaz s greškom samo ako oba ključna alata nedostaju
    if not terraform_ok and not terragrunt_ok:
        sys.exit(1)


if __name__ == "__main__":
    main()
