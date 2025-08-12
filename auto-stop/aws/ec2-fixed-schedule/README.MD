# AWS - EC2 & RDS AutoStopping Schedule

### Step 1
* Create a Harness platform api key and note it down to set for HARNESS_PLATFORM_API_KEY
* Set the AWS cli keys to verify whether the tags for the Schedule tags vm have been set correctly
* In bash shell do this
```bash
export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxx

export HARNESS_ACCOUNT_ID="xxxxxxxxxxxxxxxxxxxx"
export HARNESS_PLATFORM_API_KEY="xxxxxxxxxxxxxxxxxxxx"
```

* Verify VM details
### Verify the VM and its schedule tag value set
Get the VM instance ID
```bash
 aws ec2 describe-instances --query "Reservations[*].Instances[*].InstanceId" --output table
```
Get the VM tag values
```bash
aws ec2 describe-tags \
  --filters "Name=resource-id,Values=<instance id>" \
  --output table
```

example command
```bash
aws ec2 describe-tags \
  --filters "Name=resource-id,Values=i-0d4e8d3b96aab860a" \
  --output table
```

---

### Step 2
copy terraform.tfvars.example as terraform.tfvars and fill in the values

---

### step 3
Use terraform or open terraform (tofu) for this step

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

---

### Step 4
Goto your Harness account console in web browser and in auto stopping rules check all rules are created correctly

