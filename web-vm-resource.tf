# Author Shadi Badir


# Locals Block for custom data
locals {
webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
sudo apt update && sudo apt full-upgrade -y
sudo apt install docker.io -y

CUSTOM_DATA  
}

# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  count = var.web_linuxvm_instance_count
  name = "${local.resource_name_prefix}-web-linuxvm-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = "Standard_B1s"
  admin_username = "azureuser"
  network_interface_ids = [ element(azurerm_network_interface.web_linuxvm_nic[*].id, count.index) ]
  os_profile {
    admin_username = "web-server-usr"
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
  custom_data = base64encode(local.webvm_custom_data)  

}
