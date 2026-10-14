output "vpc_id" {
  description = "ID kreiranog VPC-a"
  value       = aws_vpc.eks_vpc.id
}

output "public_subnet_id" {
  description = "ID javnog subneta"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID privatnog subneta"
  value       = aws_subnet.private_subnet.id
}

output "eks_cluster_sg_id" {
  description = "ID bezbednosne grupe EKS klastera"
  value       = aws_security_group.eks_cluster_sg.id
}

output "eks_node_sg_id" {
  description = "ID bezbednosne grupe radnih čvorova"
  value       = aws_security_group.eks_node_sg.id
}
