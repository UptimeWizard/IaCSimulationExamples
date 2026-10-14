variable "cluster_name" {
  description = "Naziv EKS klastera"
  type        = string
}

variable "environment" {
  description = "Naziv okruženja (dev, test, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR opseg VPC mreže"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR opseg javnog subnet-a"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR opseg privatnog subnet-a"
  type        = string
}

variable "aws_region" {
  description = "AWS region (koristi se za availability zone)"
  type        = string
}
