variable "aws_region" {
  description = "AWS region za LocalStack"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Naziv EKS klastera"
  type        = string
  default     = "local-eks-cluster"
}

variable "vpc_cidr" {
  description = "CIDR opseg VPC mreže"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR opseg javnog subnet-a"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR opseg privatnog subnet-a"
  type        = string
  default     = "10.0.2.0/24"
}

variable "node_group_desired_size" {
  description = "Željeni broj čvorova u node group-u"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Maksimalan broj čvorova u node group-u"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Minimalan broj čvorova u node group-u"
  type        = number
  default     = 1
}

variable "environment" {
  description = "Okruženje (dev, prod)"
  type        = string
  default     = "dev"
}
