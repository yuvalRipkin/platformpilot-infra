locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_eks_cluster" "main" {
  name = var.cluster_name
  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids = var.private_subnets_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]

  tags = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-eks-cluster" })

}

resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
  tags = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-eks-cluster-role" })

}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_node_group" "nodes" {
  node_group_name = "${var.cluster_name}-nodes"
  cluster_name    = aws_eks_cluster.main.name
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = aws_eks_cluster.main.vpc_config[0].subnet_ids
  instance_types  = [var.instance_type]
  scaling_config {
    min_size     = var.node_min
    max_size     = var.node_max
    desired_size = var.node_desired
  }

  depends_on = [aws_eks_cluster.main,
    aws_iam_role_policy_attachment.nodes_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes_AmazonEC2ContainerRegistryReadOnly,
  aws_iam_role_policy_attachment.nodes_AmazonEKS_CNI_Policy]
  tags = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-eks-cluster-node-group" })

}

resource "aws_iam_role" "nodes" {
  name = "${var.cluster_name}-nodes-group-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-eks-cluster-node-group-role" })

}

resource "aws_iam_role_policy_attachment" "nodes_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "nodes_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "nodes_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
