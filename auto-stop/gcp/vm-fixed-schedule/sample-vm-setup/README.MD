# GCP - VM AutoStopping Fixed Schedule

### Step 1
* Set the GCP service account credentials to verify whether the schedule tags for the VM have been set correctly.
* In bash shell do this:
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your-service-account-key.json"
```

### Step 2
Copy `terraform.tfvars.example` as `terraform.tfvars` and fill in the values.

### Step 3
Use Terraform or OpenTofu for this step:
```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

### Step 4
Check whether VM has been created successfully with the correct schedule label key and value
```bash
# List all GCP compute instances
gcloud compute instances list

# Show labels/tags for a specific VM
gcloud compute instances describe <vm_name> --zone <zone> --format='get(labels)'
```