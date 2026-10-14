variable "cluster_name" {
  description = "Naziv EKS klastera, koristi se za imenovanje IAM resursa"
  type        = string
}

variable "environment" {
  description = "Naziv okruženja (dev, test, prod)"
  type        = string
}
