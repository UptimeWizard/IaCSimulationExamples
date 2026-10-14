output "eks_cluster_role_arn" {
  description = "ARN IAM uloge za EKS klaster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "ARN IAM uloge za radne čvorove"
  value       = aws_iam_role.eks_node_role.arn
}
