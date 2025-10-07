# ECS EC2 Cluster Terraform Setup (sample-ecs-ec2-cluster-setup)

This sample provisions an Amazon ECS cluster backed by EC2 instances via an Auto Scaling Group and Launch Template. Instances are tagged with a configurable `Schedule` tag so you can attach Harness AutoStopping rules by tag.

## Usage
1. **Set variables:**
   - Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in values.
2. **Initialize Terraform:**
   ```sh
   terraform init
   ```
3. **Apply:**
   ```sh
   terraform apply
   ```
4. **Verify:**
   - Instances should appear in the ECS cluster and in the ASG.
   - Instances will have tags `Name` and `Schedule`.

## Notes
- If `ami_id` is left blank, the latest ECS-optimized Amazon Linux 2 AMI is used.
- SSH private key is saved as `ecs-key.pem` (git-ignored). Permission 0600.

## Example Checks
- List cluster ARNs:
  ```sh
  aws ecs list-clusters --region <region>
  ```
- Describe capacity providers:
  ```sh
  aws ecs describe-clusters --clusters <cluster-name> --include CAPACITY_PROVIDERS --region <region>
  ```
- Verify instance tags:
  ```sh
  aws ec2 describe-tags \
    --filters "Name=resource-type,Values=instance" "Name=key,Values=Schedule" \
    --region <region> --output table
  ```

## Verify ecs cluster setup
```bash
# get public ip
aws ec2 describe-instances --region ap-south-1 \
  --filters Name=tag:aws:autoscaling:groupName,Values=<auto scaling group name> \
  --query 'Reservations[].Instances[].[InstanceId,State.Name,PublicIpAddress,PrivateIpAddress]' \
  --output table

aws ecs list-services --cluster <cluster_name> --region <region> --output table

aws ecs describe-services --cluster <cluster_name> \
  --services $(tofu output -raw service_name) --region <region> \
  --query 'services[0].[status,desiredCount,runningCount,pendingCount,launchType]' --output table

chmod 600 ecs-key.pem
ssh -i ecs-key.pem ec2-user@<PublicIP>

# On the instance:
sudo systemctl status ecs
sudo journalctl -u ecs -e
cat /etc/ecs/ecs.config     # should contain: ECS_CLUSTER=Oct03Ecs01Cluster
sudo docker ps | grep ecs   # see ecs-agent container (on ECS-optimized AL2)
```

## Cleanup
```sh
terraform destroy
```
