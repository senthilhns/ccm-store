# RDS Instance Terraform Setup

This module provisions an RDS instance with mysql 8.0, using Terraform.

```bash
aws ec2 describe-vpcs \
  --query "Vpcs[].{VpcId:VpcId, Name:Tags[?Key=='Name']|[0].Value}" \
  --output table \
  --region xxxxxx
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-xxxxx" --query "Subnets[*].SubnetId" --output text --region xxxxx  
```

Step 1: Initialize Terraform
```bash
terraform init
```

Step 2: Copy the terraform.tfvars.example file to terraform.tfvars and fill in the required values.

Step 3: Run Terraform validate and verify the tf files
```bash
terraform validate
```

Step 4: Run Terraform plan
```bash
terraform plan
```

Step 5: Run Terraform apply
```bash
terraform apply -auto-approve
```

Output will look like follows for e.g
```txt
db_identifier = "July15Rds"
rds_endpoint = "july15rds2.cfwix0zpok6p.ap-south-1.rds.amazonaws.com:3306"
rds_username = "admin"
region = "ap-south-1"
schedule_name_tag = "July15RdsSchedule"
subnet_ids = tolist([
  "subnet-0c30b316cc0e744c9",
  "subnet-0ba8751a841ad9ee7",
])
vpc_id = "vpc-0f317b7668ecdb24eb"
```

Check whether RDS instance is accessible 
```bash
mysql -h <endpoint> \
      -P 3306 \
      -u <username> \
      -p'<password>'
```