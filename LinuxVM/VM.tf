# Storage account for boot diagnostics (unique name)
resource "azurerm_storage_account" "dev-storage" {
  name                     = "diag$${var.environment}${var.Resource_group_name}"
  resource_group_name      = azurerm_resource_group.dev-Resource.name
  location                 = azurerm_resource_group.dev-Resource.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false 
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}

resource "azurerm_linux_virtual_machine" "dev-VM" {
  name                  = var.vm_name
  location              = azurerm_resource_group.dev-Resource.location
  resource_group_name   = azurerm_resource_group.dev-Resource.name
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]
  tags                  = var.tags
  admin_username      = var.admin_username
  
  
  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.dev_ssh_key.public_key_openssh
  }

  os_disk {
    name                 = "osdisk-${var.environment}-${var.vm_name}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.diag.primary_blob_endpoint
  }
}

#Added Authentication: A Linux VM requires a way to authenticate. The corrected code adds the admin_username and an admin_ssh_key block. To make this work, you also need to define the admin_username and ssh_public_key variables in your variables.tf and terraform.tfvars files, as previously described.
# If not using SSH configuration anyways not configured to this and below are the commented lists for other types of authentication.
# Install the AADSSHLoginForLinux extension to enable Entra ID login.
resource "azurerm_virtual_machine_extension" "aad_login" {
  name                 = "AADSSHLoginForLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.dev-VM.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADSSHLoginForLinux"
  type_handler_version = "1.0"
}

output "private_key" {
  value     = tls_private_key.dev_ssh_key.private_key_openssh
  sensitive = true
}

#Password Authentication: Use an admin_password and set disable_password_authentication to false for simple but less secure access.
#Microsoft Entra ID (formerly Azure AD) Authentication: Integrate with your organization's directory for secure, centralized access via Entra credentials.
#Azure Bastion and Key Vault: Use a combination of Azure Bastion for secure, RDP-like browser access and Key Vault for managing credentials.
#Managed Identities: Enable a system-assigned identity on the VM to allow it to securely authenticate with other Azure services.
#Ephemeral OpenSSH Certificates: Use Entra ID as a certificate authority to issue short-lived certificates for authentication, eliminating the need for long-term SSH keys. 