output "vpc_id" {
  value = module.myapp-vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.myapp-vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.myapp-vpc.public_subnets
}
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}
