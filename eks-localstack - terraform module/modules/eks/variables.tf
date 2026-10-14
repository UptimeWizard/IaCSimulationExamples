variable "cluster_name" {
  description = "Naziv EKS klastera"
  type        = string
}

variable "environment" {
  description = "Naziv okruženja (dev, test, prod)"
  type        = string
}

variable "eks_cluster_role_arn" {
  description = "ARN IAM uloge za EKS klaster (iz iam modula)"
  type        = string
}

variable "eks_node_role_arn" {
  description = "ARN IAM uloge za radne čvorove (iz iam modula)"
  type        = string
}

variable "public_subnet_id" {
  description = "ID javnog subneta (iz network modula)"
  type        = string
}

variable "private_subnet_id" {
  description = "ID privatnog subneta (iz network modula)"
  type        = string
}

variable "eks_cluster_sg_id" {
  description = "ID bezbednosne grupe EKS klastera (iz network modula)"
  type        = string
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
