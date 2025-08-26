env = "Dev"
resource_group_location = "SouthIndia"
resource_group_name = "rg-retail-dev"
Vnet_Name = "vnet-retail"
address_space = ["10.100.0.0/16"]
subnet_name = "snet-aks"
address_prefixes  = ["10.100.1.0/24"]
AKS_Name = "aks-retail-dev"
AKS_Region = "SouthIndia"
node_count = "3"
Managed_identity = "systemassigned"





