# AWS RDS Proxy AutoStopping Example

This folder contains Terraform to deploy a Harness AutoStopping Proxy and an AutoStopping Rule for an existing AWS RDS instance using TCP forwarding via the proxy.

## Structure
- `provider.tf`: Configures AWS and Harness providers.
- `variables.tf`: Inputs such as region, VPC/subnet, security groups, RDS instance id, proxy machine type, etc.
- `rds_auto_stop_with_proxy_rule.tf`: Creates `harness_autostopping_aws_proxy` and an `harness_autostopping_rule_rds` with TCP forwarding to the RDS port.
- `sample-rds-setup/`: Example Terraform to create a sample RDS instance (optional).

## Prerequisites
- AWS credentials configured for the selected `region`.
- An existing RDS instance identifier (`rds_instance_id`).
- Harness CCM AutoStopping set up with a Cloud Connector (`cloud_connector_id`).
- Harness Platform API key provided via `harness_api_key`.
- A VPC, Subnet, and Security Group(s) for placing the proxy in the same network where the RDS is reachable.
- A Route53 hosted zone for proxy DNS registration.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars  # fill in values
# If you prefer OpenTofu, replace terraform with tofu
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

## Notes
- The proxy exposes a stable hostname and forwards TCP traffic to your RDS instance's target port.
- `idle_time_mins` controls when the RDS instance will be stopped after inactivity observed through the proxy.
- To onboard MySQL, set `rds_target_port = 3306`. For Postgres, `5432`. Adjust per engine.
