output "eks_cluster_name" {
  description = "Naziv EKS klastera"
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint EKS klastera"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_arn" {
  description = "ARN EKS klastera"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "eks_cluster_version" {
  description = "Verzija Kubernetes-a"
  value       = aws_eks_cluster.eks_cluster.version
}

output "eks_cluster_certificate_authority" {
  description = "Certificate Authority podatak"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  sensitive   = true
}

output "eks_node_group_id" {
  description = "ID EKS node group-a"
  value       = aws_eks_node_group.eks_node_group.id
}

output "eks_node_group_status" {
  description = "Status EKS node group-a"
  value       = aws_eks_node_group.eks_node_group.status
}
