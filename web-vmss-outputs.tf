# Author Shadi Badir


output "web_vmss_id" {
  description = "Web Virtual Machine Scale Set ID"
  value = azurerm_linux_virtual_machine_scale_set.web_linuxvm.id 
}

# Output admin of the web VM
output "information_Admin" {
  description = "Web Linux VM Admin"
  value = azurerm_linux_virtual_machine_scale_set.web_linuxvm.admin_username
}

# Output password of the web VM
output "information_Password" {
  description = "Web Linux VM password"
  sensitive   = true
  value = azurerm_linux_virtual_machine_scale_set.web_linuxvm.admin_password
}