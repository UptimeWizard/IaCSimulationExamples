# EKS klaster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn
  version  = "{{ cookiecutter.kubernetes_version }}"

  vpc_config {
    subnet_ids              = [var.public_subnet_id, var.private_subnet_id]
    security_group_ids      = [var.eks_cluster_sg_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  timeouts {
    create = "30m"
    delete = "15m"
  }

  tags = {
    Name        = var.cluster_name
    Environment = var.environment
  }
}

# EKS Node Group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = [var.private_subnet_id]

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  instance_types = ["{{ cookiecutter.instance_type }}"]

  tags = {
    Name        = "${var.cluster_name}-node-group"
    Environment = var.environment
  }
}
