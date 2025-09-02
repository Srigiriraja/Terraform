env = "dev"
location = "southindia"
Resource_group_name = "rg-retail-dev"
tags = "need to use customised tags: owner = "platform-team", cost_center = "IT", workload = "vm" "
vnet_name = "vnet-retail-dev"
address_space  = ["10.40.0.0/16"]
subnet_name = "snet-app"
address_prefixes = ["10.40.10.0/24"]

# Lock SSH to YOUR IP (replace with office IP / jumpbox CIDR)
allow_ssh_from_cidr = ["203.0.113.25/32"]

create_public_ip = false  # set true only if you must expose SSH directly

vm_name = "vm-retail-app-01"
vm_size = "Standard_DS1_v2"
admin_username = "azureadmin"



# In a enterprise level 

# Put approvals on the ADO Environment (e.g., “dev-infra”, “prod-infra”).

# Use separate backend.hcl (or those variables) per environment.

# Keep NSG “allow_ssh_from_cidr” locked to your corporate IP or jump host.