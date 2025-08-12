resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
}

module "aks_network" {
  source              = "./aks-network-module"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
}

module "aks_cluster" {
  source              = "./aks-cluster-module"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  subnet_id           = module.aks_network.subnet_id
  cluster_name        = var.cluster_name
  dns_prefix          = var.dns_prefix
  node_count          = var.node_count
  vm_size             = var.vm_size
}

output "kube_config" {
  value     = module.aks_cluster.kube_config
  sensitive = true
}
