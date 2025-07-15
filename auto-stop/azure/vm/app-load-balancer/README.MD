# Quick Start Instructions

Follow these steps for a smooth setup:

## 1. Create the VM
- Go to the `app_vm_setup` directory and set up the VM.
- This will provide you with:
  - VM IP
  - VM ID
  - Resource Group Name
  - VM Name

## 2. Create Azure Application Gateway (ALB)
- Set `is_create_auto_stop_rule = false` in your variables/`terraform.tfvars`.
- Set all required ALB input parameters.
- Run:
  ```bash
  tofu apply
  ```
- This step will create the Application Gateway (ALB).

## 3. Create Harness Auto-Stop Rule
- From the previous step, get the ALB certificate ID and ALB ID (see below for how to fetch).
- Set `is_create_auto_stop_rule = true` in your variables/`terraform.tfvars`.
- Run:
  ```bash
  tofu apply
  ```
- This will create the Harness auto-stop rule for your VM.

---

Add the following to `terraform.tfvars`  
deployment_name, resource_group_name, 
```terraform
deployment_name     = "hns-2025-jun-24"
resource_group_name = "hns-2025-jun-24-rg"
location            = "Central India"

public_ip = true

target_vm_public_ip = "52.172.183.226"

# Tags (optional)
tags = {
  environment = "dev"
}
```


Get the azure vm, alb ids follow below example

```bash

export RESOURCE_GROUP_NAME='hns-2025-jun-24-rg'
export VM_NAME='hns-2025-jun-24-vm'
export APP_GATEWAY_NAME='hns-2025-jun-24-gw'


az network application-gateway ssl-cert list \
  --resource-group $RESOURCE_GROUP_NAME \
  --gateway-name $APP_GATEWAY_NAME \
  --query "[].id" \
  --output tsv

az network application-gateway show \
  --name $APP_GATEWAY_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --query "id" \
  --output tsv

az vm show \
  --name $VM_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --query "id" \
  --output tsv
```

then do this

```bash
tofu init
tofu validate
tofu plan
tofu apply
