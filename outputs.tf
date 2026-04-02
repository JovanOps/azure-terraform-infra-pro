output "resource_group_name" {
  value = module.resource_group.name
}

output "resource_group_location" {
  value = module.resource_group.location
}
output "vm_public_ip" {
  value = data.azurerm_public_ip.this.ip_address
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.this.name
}