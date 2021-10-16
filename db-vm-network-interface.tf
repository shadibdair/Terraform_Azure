# Author Shadi Badir

# Resource-2: Create Network Interface
resource "azurerm_network_interface" "db_linuxvm_nic" {
  name                = "${local.resource_name_prefix}-db-linuxvm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "db-linuxvm-ip-1"
    subnet_id                     = azurerm_subnet.dbsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
