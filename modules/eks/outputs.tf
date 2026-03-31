output "cluster_name" {
  description = "Name of the EKS cluster. Used for kubectl config, ArgoCD, and CI/CD references."
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "The cluster's API server URL. Used for kubectl config and ArgoCD."
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority" {
  description = "The base64-encoded TLS certificate authority data. Used to authenticate kubectl connections."
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "Used for enabling other modules to allow traffic from and to the cluster"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "node_group_name" {
  description = "The node group name. Used for debugging and reference"
  value       = aws_eks_node_group.nodes.node_group_name
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL. Required for IRSA (IAM Roles for Service Accounts) setup."
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}
