# AWS EC2 Proxy AutoStopping Example

This folder contains Terraform modules and scripts to deploy an AWS EC2 instance with Harness CCM AutoStopping integration, adapted from the Azure sample.

## Structure
- `cert_gen.tf`: Generates a self-signed TLS certificate and stores it in AWS ACM.
- `locals.tf`: Defines local values for key pair and other settings.
- `provider.tf`: Configures AWS and Harness providers.
- `variables.tf`: Variables for AWS region, VPC, subnet, security groups, etc.
- `sample-vm-setup/`: Example setup for a sample EC2 VM.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars # edit and set parameters
tofu init
tofu validate
tofu plan
tofu apply -auto-approve
```

## Notes
- Ensure your AWS credentials are configured (via environment or AWS CLI).
- The EC2 instance and proxy will be deployed in the specified VPC/subnet.
- Harness CCM AutoStopping will manage the instance based on your rule configuration.