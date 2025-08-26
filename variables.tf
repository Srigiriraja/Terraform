variable "env" {
     type = string
     description = "development Environment"
}

variable "resource_group_location" {
    type = string
    description = "Location of my rg"
  
}

variable "resource_group_name" {
   type = string
   description = "name of my rg"
}

variable "Vnet_Name" {
    type = string
    description = "Name of my Vnet"
  
}

variable "address_space" {
    type = list(string)
    description = "address space of my vnet"
  
}

variable "subnet_name" {
    type = string
    description = "Name of my subnet"
}

variable "address_prefixes" {
  type = list(string)
  description = "My adress list of subnet"
}

variable "AKS_Name" {
  type = string
  description = "name of my AKS"
  
}

variable "AKS_Region" {
  type = string
  description = "name of my region"
}

variable "node_count" {
  type = number
  description = "number of nodes "
}

variable "Managed_identity" {
    type = string
    description = "systemassigned configured to my Aks cluster in members section" 
}