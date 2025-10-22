# Minimal ElastiCache Redis Setup for Policy Testing

## Purpose
This Terraform setup creates a minimal-cost AWS ElastiCache Redis cluster (legacy node type) for testing:
- Low memory/data-tier usage detection
- Legacy node type notification

## Cost Minimization
- Uses `cache.t2.micro` (legacy, cheapest eligible node type)
- Single node
- No replicas or multi-AZ

## Usage

1. **Configure your AWS credentials** (via environment or profile).
2. **Set required variables** in `terraform.tfvars` or via CLI:
   - `vpc_id` (your VPC ID)
   - `subnet_ids` (list of subnet IDs in your VPC)
3. **Initialize Terraform:**
   ```sh
   terraform init
   ```
4. **Apply:**
   ```sh
   terraform apply
   ```
   
5. ** Test whether the redis cluster is working **
```bash
  tofu output ec2_ssh_private_key > ec2_test_key.pem
  # Now remove the <<EOT and EOT from ec2_test_key.pem
  chmod 600 ec2_test_key.pem
  tofu output cluster_endpoint # get the cluster endpoint this is the <cluster_endpoint>
  tofu output ec2_public_ip # this is the <public_ip_of_ec2_instance_created>
  ssh -i ec2_test_key.pem ubuntu@<public_ip_of_ec2_instance_created> #
  redis-cli -h <cluster_endpoint> -p 6379
  set fruitkey peachvalue
  get fruitkey  # you should see peachvalue for this
  # type Ctrl-D to get out of the redis-cli prompt
```

. **Destroy:**
   ```sh
   terraform destroy
   ```

## Outputs
- Cluster ID
- Endpoint
- Node type

## Cleanup
Always destroy the setup when done to avoid unwanted AWS charges!
