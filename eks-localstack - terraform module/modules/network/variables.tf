variable "cluster_name" {
  description = "Naziv EKS klastera, koristi se za imenovanje resursa"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR opseg VPC mreže"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR opseg javnog subneta"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR opseg privatnog subneta"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Naziv okruženja (dev, test, prod)"
  type        = string
}
