terraform {
  required_providers {
    azurerm = {
        source = "Hashicorp/azurerm"
        version = "3.8.2"
    }
  }
 required_providers {

    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
}
}

# Backend Config File for container storage 
backend "azurerm" {
    resource_group_name  = "rg-retail-dev"
    storage_account_name = "stterraformstate01"
    container_name       = "tfstate"
    key                  = "aks-dev.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a355c32e-4a22-4b05-aab4-be236850fa6e"
}
