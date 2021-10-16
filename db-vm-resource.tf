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
resource "azurerm_virtual_machine" "db_linuxvm" {
  name = "${local.resource_name_prefix}-db-linuxvm"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = "Standard_B1s"
  admin_username = "azureuser-db"
  network_interface_ids = azurerm_network_interface.db_linuxvm_nic.id
  os_profile {
    admin_username = "db-server-usr"
    admin_password = "Shadishadi1"
  }
  os_disk {
    name = "myosdisk1"
    # Specifies the caching requirements for the OS disk
    caching = "ReadWrite"
    storage_account_type = "Standard_HDD"
  }
  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "20.04-LTS-Gen1"
    version = "latest"
  }
  #custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")    
  custom_data = base64encode(local.dbvm_custom_data)  

}
