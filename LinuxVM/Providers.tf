terraform {
  required_providers {
    azurerm = {
        source = "Hashicorp/Azurerm"
        version = "3.8.0"
    }
  }
   required_providers {

    azapi = {
      source  = "azure/azapi"
      version = "1.5"
}
   }
}
provider "azurerm" {
  features {}
  subscription_id = "xxxx-xxxx-xxxx-xxxx"
}

