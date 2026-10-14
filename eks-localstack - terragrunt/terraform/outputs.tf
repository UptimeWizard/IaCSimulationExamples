output "eks_cluster_name" {
  description = "Naziv EKS klastera"
  value       = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint EKS klastera"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_arn" {
  description = "ARN EKS klastera"
  value       = module.eks.eks_cluster_arn
}

output "eks_cluster_version" {
  description = "Verzija Kubernetes-a"
  value       = module.eks.eks_cluster_version
}

output "eks_cluster_certificate_authority" {
  description = "Certificate Authority podatak"
  value       = module.eks.eks_cluster_certificate_authority
  sensitive   = true
}

output "vpc_id" {
  description = "ID VPC-a"
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "ID javnog subnet-a"
  value       = module.network.public_subnet_id
}

output "private_subnet_id" {
  description = "ID privatnog subnet-a"
  value       = module.network.private_subnet_id
}

output "eks_cluster_security_group_id" {
  description = "ID bezbednosne grupe EKS klastera"
  value       = module.network.eks_cluster_sg_id
}

output "eks_node_security_group_id" {
  description = "ID bezbednosne grupe radnih čvorova"
  value       = module.network.eks_node_sg_id
}

output "eks_cluster_role_arn" {
  description = "ARN IAM uloge za EKS klaster"
  value       = module.iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  description = "ARN IAM uloge za radne čvorove"
  value       = module.iam.eks_node_role_arn
}

output "eks_node_group_id" {
  description = "ID EKS node group-a"
  value       = module.eks.eks_node_group_id
}

output "eks_node_group_status" {
  description = "Status EKS node group-a"
  value       = module.eks.eks_node_group_status
}
