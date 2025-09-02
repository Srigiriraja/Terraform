resource "azurerm_resource_group" "dev-Resource" {
    name = var.Resource_group_name
    location = var.location
    tags = var.tags
}

resource "azurerm_virtual_network" "dev-vent" {
  name = var.vnet_name
  resource_group_name = azurerm_resource_group.dev-Resource.name
  location = azurerm_reource_group.dev-Resource.location
  address_space = var.address_space
  tags = var.tags
}

resource "azurerm_subnet" "dev-subnet" {
    name = var.subnet_name
    resource_group_name = azurerm_resource_group.dev-Resource.name
    virtual_network_name = azurerm_virtual_network.dev-vnet.name
    address_prefixes = var.address_prefixes 
}

resource "azurerm_network_security_group" "dev-NSG" {
    name = "nsg-${var.environment}-ssh"
    location = azurerm_resource_group.dev-Resource.location
    resource_group_name = azurerm_resource_grooup-dev-Resource.name
    tags = var.tags

    security_rule {
        name = "Allow-SSH-From-Trusted"
        priority = 100
        direction = "Inbound"
        access = "allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefixes = "var.allow_ssh_from_cidr"
        destination_address_prefix = "*"

    } 
   # Deny all else inbound is implicit; outbound is Allow by default
}

resource "azurerm_public_ip" "pip" {
    count = var.create_public_ip ? 1:0
    name = "pip-${var.environment}-${var.vm_name}"
    location = azurerm_resource_group.dev-Resource.location
    resource_group_name = azurerm_resource_group.dev-Resource.name
    allocation_method = "static"
    sku = "standard"
    tags = var.tags 
}


resource "azurerm_network_interface" "nic" {
    name                = "nic-${var.environment}-${var.vm_name}"
    location = azurerm_resource_group.dev-Resource.location
    resource_group_name = azurerm_resource_group.dev-Resource.name
    tags = var.tags

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.pip[0].id : null
}

}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

