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
resource "azurerm_linux_virtual_machine_scale_set" "web_linuxvm" {
    name = "${local.resource_name_prefix}-web-vmss"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    sku = "Standard"
    disable_password_authentication = "false"
    admin_username = "web-server-bonus-advanced"
    admin_password = "Shadishadi1"
    instances = 3

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

  upgrade_mode = "Automatic"

  network_interface {
    name    = "web-vmss-nic"
    primary = true
    network_security_group_id = azurerm_network_security_group.web_vmss_nsg.id
    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.websubnet.id  
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id]
    }
  }

  custom_data = base64encode(local.webvm_custom_data)  

}