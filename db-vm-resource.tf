# Author Shadi Badir


# Resource: Azure Linux Virtual Machine
resource "azurerm_postgresql_server" "db_postgress" {
  name = "dbpostgress"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  administrator_login          = "postgressdb"
  administrator_login_password = "Shadishadi1"
  sku_name   = "GP_Gen5_4"
  version    = "9.6"
  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true
  public_network_access_enabled    = false
  ssl_enforcement_enabled           = false
  #ssl_enforcement_enabled          = true
  #ssl_minimal_tls_version_enforced = "TLS1_2"
}

# # Resource: Azure MySQL Firewall Rule 
# resource "azurerm_mysql_firewall_rule" "mysql_fw_rule" {
#   name                = "allow-access-from--publicip"
#   resource_group_name = azurerm_resource_group.rg.name
#   server_name         = azurerm_mysql_server.mysql_server.name
#   start_ip_address    = azurerm_public_ip.web_lbpublicip.ip_address
#   end_ip_address      = azurerm_public_ip.web_lbpublicip.ip_address
# }