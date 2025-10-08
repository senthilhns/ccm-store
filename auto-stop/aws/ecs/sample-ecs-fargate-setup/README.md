# ECS Fargate Setup with Terraform

This Terraform configuration sets up an Amazon ECS cluster with Fargate launch type, including all necessary IAM roles, security groups, and logging.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform 1.0.0 or later installed
- A VPC with public subnets (or private subnets with NAT)

## Usage

1. Create a `terraform.tfvars` file with your configuration:

```hcl
region     = "us-west-2"
vpc_id     = "vpc-xxxxxxxx"
subnet_ids = ["subnet-xxxxxx1", "subnet-xxxxxx2"]

# Optional: Customize these values as needed
cluster_name = "my-fargate-cluster"
service_name = "my-fargate-service"
container_port = 80
container_cpu = 256
container_memory = 512

# Security
http_ingress_cidr = ["0.0.0.0/0"]  # Restrict this in production

# Tags
tags = {
  Environment = "dev"
  Project     = "my-project"
  ManagedBy   = "terraform"
}
```

2. Initialize Terraform:

```bash
terraform init
```

3. Review the execution plan:

```bash
terraform plan
```

4. Apply the configuration:

```bash
terraform apply
```

## Configuration

### Variables

- `region`: AWS region to deploy resources in (required)
- `vpc_id`: The VPC ID where the ECS Fargate service will be deployed (required)
- `subnet_ids`: List of subnet IDs for the Fargate service (required)
- `cluster_name`: Name of the ECS cluster (default: "demo-ecs-fargate-cluster")
- `service_name`: Name of the ECS Service (default: "nginx-fargate-svc")
- `service_desired_count`: Number of tasks to run (default: 1)
- `container_port`: Port that the container will listen on (default: 80)
- `container_cpu`: CPU units for the container (1024 units = 1 vCPU, default: 256)
- `container_memory`: Memory for the container in MiB (default: 512)
- `assign_public_ip`: Whether to assign a public IP (default: true)
- `enable_auto_scaling`: Whether to enable auto scaling (default: false)
- `min_capacity`: Minimum number of tasks when auto scaling (default: 1)
- `max_capacity`: Maximum number of tasks when auto scaling (default: 2)
- `http_ingress_cidr`: List of CIDR blocks allowed to access the service (default: ["0.0.0.0/0"])
- `tags`: A map of tags to add to all resources (default: {})

### Outputs

- `ecs_cluster_name`: The name of the ECS cluster
- `ecs_service_name`: The name of the ECS service
- `ecs_service_id`: The ID of the ECS service
- `task_definition_arn`: The ARN of the task definition
- `task_execution_role_arn`: The ARN of the ECS task execution role
- `task_role_arn`: The ARN of the ECS task role
- `cloudwatch_log_group_name`: The name of the CloudWatch log group
- `security_group_id`: The ID of the security group
- `service_url`: The URL to access the service (if load balancer is attached)

## Clean Up

To remove all resources created by this configuration:

```bash
terraform destroy
```

## Notes

- This configuration uses the `nginx:latest` container image by default. Update the container definition in `ecs_task_definition.tf` to use your application's container image.
- For production use, consider adding a load balancer and enabling HTTPS.
- The default security group allows inbound HTTP traffic from anywhere. Restrict this in production environments.
