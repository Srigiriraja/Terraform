# Resource Group 
resource "azurerm_resource_group_name" "dev_resource_group" {
    name = var.resource_group_name.name
    location = var.resource_group_location.location
}

resource "azurerm_virtual_network" "vnet" {
    name = "vnet-retail-${var.env}"
    location = var.resource_group_location.location
    resource_group_name = var.resource_group_name.name
    address_space = ["10.100.0.0/16"]
}

resource "azurerm_subnet" "aks-subnet" {
    name = "snet-aks"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.100.1.0/24"]
}

# AKS Cluster 

resource "azurerm_kubernetes_cluster" "aks" {
    name = var.AKS_Name
    location = var.AKS_Region
    resource_group_name = var.resource_group_name
    dns_prefix  = "aks-${var.env}"

default_node_pool {
  name = "system"
  node_count = var.node_count
  vm_size = "Standard_DS2_v2"
  vnet_subnet_id = azurerm_subnet.aks_subnetid
}

identity {
  type = "systemassigned"
}

network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }
}

