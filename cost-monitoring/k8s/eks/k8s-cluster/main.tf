#
# Create VPC and subnets
#
module "eks_network" {
  source = "./eks-network-module"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["ap-south-1a", "ap-south-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  name_prefix = var.name_prefix
  tags = {
    Environment = "dev"
  }
}

#
# Create EKS cluster
#
module "eks" {
  source = "./eks-cluster-module"
  name_prefix = var.name_prefix
  vpc_id = module.eks_network.vpc_id
  private_subnet_ids = module.eks_network.private_subnet_ids
  tags = {
    Environment = "dev"
  }
  node_count = 1
  instance_types = ["t3.xlarge"]
  key_pair_name = "newkey"
  ssh_key_name = module.eks.key_pair_name # Add your key name if needed
}

output "vpc_id" {
  value = module.eks_network.vpc_id
}

output "public_subnet_ids" {
  value = module.eks_network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.eks_network.private_subnet_ids
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
