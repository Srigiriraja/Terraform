variable "environment" {
    type = string
    description = "env = dev : this is for dev environment"  
}

variable "location" {
    type = string
    description = "location = southindia: deployement of resources and Resource groups set to southindia region" 
}

variable "Resource_group_name" {
    type = string
    description = "rg-retail-dev" 
}

# Networking

variable "vnet_name" {
    type = string
    description = "vnet-retail-dev:Name of our Vnet is set to this in infra"
}

variable "address_space" {
    type = list(string)
    description = "[10.40.0.0/16] : set in between these ip address range"
}

variable "subnet_name" {
    type = string
    description = "snet-app : created Vnet for that this is subnet and its name"
}

variable "address_prefixes" {
    type = list(string)
    description = "[10.40.10.0/24] : This is the address range of our subnet we have assigned" 
}

variable "allow_ssh_from_cidr" {
    type = list(string)
    description = "Lock SSH to OUR IP (replace with office IP / jumpbox CIDR)" 
}

variable "create_public_ip" {
    type = bool
    description = "false  # set true only if you must expose SSH directly" 
}

variable "vnet_name" {
    type = string
    description = "Assigned name to our Vnet"
}

variable "vm_size" {
    type = string
    description = "set to standard_Dsv_1 this is basic varies in prod as per config requirement and jobs" 
}

variable "admin_username" {
    type = string
    description = "set admin user name but pass word should not be hardcoded and should be saved in Keyvault"
}

