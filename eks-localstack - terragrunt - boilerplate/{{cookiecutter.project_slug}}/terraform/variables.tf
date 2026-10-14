variable "aws_region" {
  description = "AWS region za LocalStack"
  type        = string
  default     = "{{ cookiecutter.aws_region }}"
}

variable "cluster_name" {
  description = "Naziv EKS klastera"
  type        = string
  default     = "{{ cookiecutter.cluster_name }}"
}

variable "vpc_cidr" {
  description = "CIDR opseg VPC mreže"
  type        = string
  default     = "{{ cookiecutter.dev_vpc_cidr }}"
}

variable "public_subnet_cidr" {
  description = "CIDR opseg javnog subnet-a"
  type        = string
  default     = "{{ cookiecutter.dev_public_subnet_cidr }}"
}

variable "private_subnet_cidr" {
  description = "CIDR opseg privatnog subnet-a"
  type        = string
  default     = "{{ cookiecutter.dev_private_subnet_cidr }}"
}

variable "node_group_desired_size" {
  description = "Željeni broj čvorova u node group-u"
  type        = number
  default     = {{ cookiecutter.dev_node_desired }}
}

variable "node_group_max_size" {
  description = "Maksimalan broj čvorova u node group-u"
  type        = number
  default     = {{ cookiecutter.dev_node_max }}
}

variable "node_group_min_size" {
  description = "Minimalan broj čvorova u node group-u"
  type        = number
  default     = {{ cookiecutter.dev_node_min }}
}

variable "environment" {
  description = "Okruženje (dev, prod)"
  type        = string
  default     = "dev"
}
