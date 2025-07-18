

### Run the script


### Step 1
```bash
cd app_vm_setup
# modify the terraform.tfvars, then run the following command
tofu init
tofu validate
tofu plan
tofu apply
cd ..
```

### Step 2
get <resource_group_name> <vm_name> from step 1
```bash
sh get_vars.sh <resource_group_name> <vm_name>
```

### example script for getting vm vars
```bash
RG="hns-autostop-azure-002-rg"
VM="hns-5050-vm"

# Get the VM's VNet, Subnet, and NIC
NIC=$(az vm show -g "$RG" -n "$VM" --query 'networkProfile.networkInterfaces[0].id' -o tsv)
VNET=$(az network nic show --ids "$NIC" --query 'ipConfigurations[0].subnet.id' -o tsv | awk -F'/subnets/' '{print $1}')
SUBNET=$(az network nic show --ids "$NIC" --query 'ipConfigurations[0].subnet.id' -o tsv)
NSG=$(az network nic show --ids "$NIC" --query 'networkSecurityGroup.id' -o tsv)

# Get the subscription ID
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# Print values for terraform.tfvars
echo "resource_group_name = \"$RG\""
echo "deployment_name = \"$VM\""
echo "vnet = \"$VNET\""
echo "subnet_id = \"$SUBNET\""
echo "security_groups = [\"$NSG\"]"
echo "subscription_id = \"$SUBSCRIPTION_ID\""
```

These two values should be correctly

this_tf_principal_id - refers to the current terraform execution principal
e.g this_tf_principal_id = "a533a487-de55-4bad-add6-c8aa6517526e"

harness_principal_id - refers to the harness principal that will try to access the certificates
e.g harness_principal_id = "01443661-7afd-465f-9c21-9d84e7034f06"


if you are unsure follow this below instructions

now when you do 
tf apply you will get like this (this value is not constant)
group or application 'appid=cb3b78b0-7c34-4ce9-b516-6ff3e7d3be3d;oid=a533a487-de55-4bad-add6-c8aa6517526e

copy "a533a487-de55-4bad-add6-c8aa6517526e" oid=a533a487-de55-4bad-add6-c8aa6517526e
and set that as 

In Azure console Goto Keyvaults -> Access policies -> Create -> Add permissions and in 
principal search for a533a487-de55-4bad-add6-c8aa6517526e

This issue will occur once more for Harness principal permission
do the same permission allow with the Harness principal id


for tofu destroy do this when message like below shown
azurerm_key_vault.proxy: Still destroying... [id=/subscriptions/ba1879ae-bce3-4ba5-9d49-...soft.KeyVault/vaults/pxykv-jun27pxy3rg, 8m0s elapsed]

az keyvault purge --name pxykv-jun27pxy3rg
