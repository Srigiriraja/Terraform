terraform {
# Backend Config File for container storage 
backend "azurerm" {
    resource_group_name  = "rg-tfstate-prod"
    storage_account_name = "sttfstateprod01"
    container_name       = "tfstate"
    key                  = "linux-vm/dev.tfstate"
  }
}

# Init later with: terraform init -backend-config=Backend.tf Command 


# In a enterprise level 

# Put approvals on the ADO Environment (e.g., “dev-infra”, “prod-infra”).

# Use separate backend.hcl (or those variables) per environment.

# Keep NSG “allow_ssh_from_cidr” locked to your corporate IP or jump host.

