# Author Shadi Badir


# Locals Block for custom data
locals {
dbvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
sudo apt update && sudo apt full-upgrade -y
sudo apt install docker.io -y
CUSTOM_DATA  
}

# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "db_linuxvm" {
  name = "${local.resource_name_prefix}-db-linuxvm"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = "Standard_B1s"
  disable_password_authentication = "false"
  admin_username = "db-server-usr"
  admin_password = "Shadishadi1"
  network_interface_ids = [ azurerm_network_interface.db_linuxvm_nic.id ]
  # network_interface_ids = azurerm_network_interface.db_linuxvm_nic.ip_configuration

  os_disk {
    name = "DBosdisk1"
    # Specifies the caching requirements for the OS disk
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }
  custom_data = base64encode(local.dbvm_custom_data)  

}
