#!/bin/bash
# Export kubeconfig for AKS cluster
RESOURCE_GROUP=${1:-myResourceGroup}
CLUSTER_NAME=${2:-myAKSCluster}
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME
