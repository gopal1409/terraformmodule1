output "resource_group_id" {
  value = azurerm_resource_group.myrg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.myrg.name
}
output "resource_group_location" {
  value = azurerm_resource_group.myrg.location
}
output "virtual_network_name" {
  value = azurerm_virtual_network.myvnet.name
}

output "network_interface_id" {
  value = azurerm_network_interface.myvmnic.id
}

