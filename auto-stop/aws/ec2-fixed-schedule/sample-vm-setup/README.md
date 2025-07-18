# EC2 Instance Terraform Setup (test-vm-setup)

This module provisions an AWS EC2 instance (t3.nano, Ubuntu 22.04) with an SSH key pair, using Terraform.

## Features
- Region is configurable via variable
- SSH key pair is generated and uploaded to AWS
- Private key is saved locally as `ec2-key.pem` (git-ignored)
- Instance is tagged with Name and Schedule (both configurable)
- Outputs instance ID, public IP, key info

## Usage
1. **Set variables:**
   - Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in values (especially `ami_id` for your region).
2. **Initialize Terraform:**
   ```sh
   terraform init
   ```
3. **Apply:**
   ```sh
   terraform apply
   ```
4. **Access your instance:**
   - Use the generated `ec2-key.pem` for SSH (permissions: 0600).
   - Example:
     ```sh
     ssh -i ec2-key.pem ubuntu@<public_ip>
     ```

## Finding the Ubuntu 22.04 AMI ID
- Use the AWS Console or CLI:
  ```sh
  aws ec2 describe-images \
    --owners 099720109477 \
    --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" \
    --query "Images[*].[ImageId,CreationDate]" \
    --region <your-region> \
    --output text | sort -k2 -r | head -n1
  ```

## Security Notes
- The SSH private key (`ec2-key.pem`) is git-ignored by default for safety.
- Never share your private key.

## Cleanup
To destroy resources:
```sh
terraform destroy
```
