# Azure - VM AutoStopping Fixed Schedule

### Step 1
* Create a Harness platform api key and note it down to set for HARNESS_PLATFORM_API_KEY
* Set the Azure cli keys to verify whether the tags for the Schedule tags vm have been set correctly
* In bash shell do this
```bash
export HARNESS_ACCOUNT_ID="xxxxxxxxxxxxxxxxxxxx"
export HARNESS_PLATFORM_API_KEY="xxxxxxxxxxxxxxxxxxxx"

az vm list --output table
az vm show --name <vm_name> --resource-group <resource_group_name> --query tags```
```

### Step 2
Copy terraform.tfvars.example as terraform.tfvars and fill in the values

### step 3
Use terraform or open terraform (tofu) for this step

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

### Step 4
Goto your Harness account console in web browser and in auto stopping rules check all rules are created correctly

