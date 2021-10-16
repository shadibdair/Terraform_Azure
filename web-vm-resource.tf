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
  for_each = var.web_linuxvm_instance_count
  name = "${local.resource_name_prefix}-web-linuxvm-${each.key}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = "Standard_B1s"
  disable_password_authentication = "false"
  admin_username = "web-server-${each.key}"
  admin_password = "Shadishadi1"
  network_interface_ids = [ azurerm_network_interface.web_linuxvm_nic[each.key].id ]

  os_disk {
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
  #custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")    
  custom_data = base64encode(local.webvm_custom_data)  

}
