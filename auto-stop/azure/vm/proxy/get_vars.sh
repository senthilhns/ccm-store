#!/bin/bash

# Usage: sh get_vars.sh <resourcegroupname> <vmname>

if [ "$#" -ne 2 ]; then
  echo "Usage: sh $0 <resourcegroupname> <vmname>"
  exit 1
fi

RESOURCE_GROUP="$1"
VM_NAME="$2"

echo "Resource Group: $RESOURCE_GROUP"
echo "VM Name: $VM_NAME"

# Example: Fetch VM details using Azure CLI (uncomment if needed)
# az vm show -g "$RESOURCE_GROUP" -n "$VM_NAME"

# Get the VM's VNet, Subnet, and NIC
NIC=$(az vm show -g "$RESOURCE_GROUP" -n "$VM_NAME" --query 'networkProfile.networkInterfaces[0].id' -o tsv)
VNET=$(az network nic show --ids "$NIC" --query 'ipConfigurations[0].subnet.id' -o tsv | awk -F'/subnets/' '{print $1}')
SUBNET=$(az network nic show --ids "$NIC" --query 'ipConfigurations[0].subnet.id' -o tsv)
NSG=$(az network nic show --ids "$NIC" --query 'networkSecurityGroup.id' -o tsv)

# Get the subscription ID
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# Print values for terraform.tfvars
echo "resource_group_name = \"$RESOURCE_GROUP\""
echo "deployment_name = \"$VM_NAME\""
echo "vnet = \"$VNET\""
echo "subnet_id = \"$SUBNET\""
echo "security_groups = [\"$NSG\"]"
echo "subscription_id = \"$SUBSCRIPTION_ID\""
