variable "cluster_name" {
  description = "Naziv EKS klastera"
  type        = string
}

variable "environment" {
  description = "Naziv okruženja (dev, test, prod)"
  type        = string
}
