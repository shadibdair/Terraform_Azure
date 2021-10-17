# Author Shadi Badir


# Resource: Azure Linux Virtual Machine
resource "azurerm_postgresql_server" "db_postgress" {
  name = "${local.resource_name_prefix}-db_postgress"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  administrator_login          = "db-postgress-usr"
  administrator_login_password = "Shadishadi1"
  network_interface_ids = [ azurerm_network_interface.db_postgress_nic.id ]
  sku_name   = "GP_Gen5_4"
  version    = "9.6"
  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true
  public_network_access_enabled    = false
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
  #ssl_enforcement_enabled          = true
  #ssl_minimal_tls_version_enforced = "TLS1_2"
}

# Resource: Azure MySQL Database / Schema
resource "azurerm_mysql_database" "webappdb" {
  name                = var.mysql_db_schema
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Resource-3: Azure MySQL Firewall Rule 
resource "azurerm_mysql_firewall_rule" "mysql_fw_rule" {
  name                = "allow-access-from--publicip"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysql_server.name
  start_ip_address    = azurerm_public_ip.web_lbpublicip.ip_address
  end_ip_address      = azurerm_public_ip.web_lbpublicip.ip_address
}

# Resource: Azure MySQL Virtual Network Rule
resource "azurerm_mysql_virtual_network_rule" "mysql_virtual_network_rule" {
  name                = "mysql-vnet-rule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysql_server.name
  subnet_id           = azurerm_subnet.websubnet.id
}