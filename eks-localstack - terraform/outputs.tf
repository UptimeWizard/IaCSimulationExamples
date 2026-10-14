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

output "vpc_id" {
  description = "ID VPC-a"
  value       = aws_vpc.eks_vpc.id
}

output "public_subnet_id" {
  description = "ID javnog subnet-a"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID privatnog subnet-a"
  value       = aws_subnet.private_subnet.id
}

output "eks_cluster_security_group_id" {
  description = "ID bezbednosne grupe EKS klastera"
  value       = aws_security_group.eks_cluster_sg.id
}

output "eks_node_security_group_id" {
  description = "ID bezbednosne grupe radnih čvorova"
  value       = aws_security_group.eks_node_sg.id
}

output "eks_cluster_role_arn" {
  description = "ARN IAM uloge za EKS klaster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "ARN IAM uloge za radne čvorove"
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_node_group_id" {
  description = "ID EKS node group-a"
  value       = aws_eks_node_group.eks_node_group.id
}

output "eks_node_group_status" {
  description = "Status EKS node group-a"
  value       = aws_eks_node_group.eks_node_group.status
}
