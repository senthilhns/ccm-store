# EKS Network Module

This Terraform module provisions the foundational AWS network infrastructure required to run an EKS cluster securely and with high availability.

## Features
- VPC with DNS support
- Two public and two private subnets across two AZs
- Internet Gateway for public subnets
- NAT Gateway (with Elastic IP) for private subnets
- Proper route tables for public/private subnets
- Outputs VPC ID, public subnet IDs, and private subnet IDs

## Usage
```hcl
module "eks_network" {
  source = "./eks-network-module"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  name_prefix = "myeks"
  tags = {
    Environment = "dev"
  }
}
```

## Outputs
- `vpc_id`: The VPC ID
- `public_subnet_ids`: List of public subnet IDs
- `private_subnet_ids`: List of private subnet IDs
