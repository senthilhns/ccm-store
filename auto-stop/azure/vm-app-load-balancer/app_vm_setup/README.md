# Azure VM Terraform Deployment

## Prerequisites
- Azure CLI installed and logged in (`az login`)
- Terraform or OpenTofu installed
- Contributor access to an Azure subscription

## 1. Create a Service Principal for Terraform
This allows Terraform to authenticate to Azure non-interactively.

```
az ad sp create-for-rbac --name "<your-app-name>" --role="Contributor" --scopes="/subscriptions/$(az account show --query id -o tsv)"
```
- Note the `appId` (client_id), `password` (client_secret), and `tenant` (tenant_id) from the output.
- Get your subscription ID:
  ```
  az account show --query id -o tsv
  ```

## 2. Export Azure Credentials as Environment Variables
Replace values with your actual IDs and secrets:

```
export ARM_SUBSCRIPTION_ID="<subscription_id>"
export ARM_CLIENT_ID="<appId>"
export ARM_CLIENT_SECRET="<password>"
export ARM_TENANT_ID="<tenant>"
```

Add these to your `~/.bashrc` or `~/.zshrc` for persistence.

## 3. Generate an SSH Key Pair for VM Login
Generate a new key (do this in the project directory):

```
ssh-keygen -t rsa -b 4096 -f az_vm_ssh_key -N "" -C "azure-vm-key"
```
- This creates `az_vm_ssh_key` (private) and `az_vm_ssh_key.pub` (public).
- **Do not commit these files to version control.** They are already in `.gitignore`.

## 4. Configure Your Variables
- Create a file for e.g ~/tmp/e1.sh then add the following inside the file
```bash
#!/bin/bash

# Deployment info
export TF_VAR_deployment_name="hns-2025-06-003"
export TF_VAR_resource_group_name="${TF_VAR_deployment_name}-rg"
export TF_VAR_location="Central India"

# VM configuration
export TF_VAR_vm_size="Standard_B1ms"
export TF_VAR_admin_username="azureuser"
export TF_VAR_os_disk_size_gb=30
export TF_VAR_disk_type="Standard_LRS"
export TF_VAR_public_ip=true

# Tags (must be JSON string or use CLI vars instead)
export TF_VAR_tags='{  "environment": "dev" }'
```
- then do this
```bash
  source ~/tmp/e1.sh
```
- check whether all values are set correctly as follows
```bash
$ env | grep '^TF_'
```
you will see some output like 

```
TF_VAR_resource_group_name=hns-2025-06-003-rg
TF_VAR_admin_username=azureuser
TF_VAR_public_ip=true
TF_VAR_disk_type=Standard_LRS
TF_VAR_vm_size=Standard_B1ms
TF_VAR_os_disk_size_gb=30
TF_VAR_location=Central India
TF_VAR_deployment_name=hns-2025-06-003
TF_VAR_tags={  "environment": "dev" }
```

## 5. Deploy
```
terraform init
terraform plan
terraform apply
```

## 6. Access Your VM
After deployment, get the public IP from Terraform outputs or the Azure Portal:

```
ssh -i az_vm_ssh_key azureuser@<VM_PUBLIC_IP>
```

## 7. Clean Up
To destroy all resources:
```
terraform destroy
```

---

**Notes:**
- The OS disk is persistent and will retain all changes across VM reboots and power cycles.
- The provisioning script (`az_vm-init.sh`) will run on first boot to install and configure nginx with SSL.
- For custom initialization, edit `az_vm-init.sh` or set the `custom_data` variable with a base64-encoded script.
