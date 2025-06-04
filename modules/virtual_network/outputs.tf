output "vnet_name" {
  description = "The name of the virtual network. Changing this forces a new resource to be created."
  value       = azurerm_virtual_network.source_vnet.name
  sensitive = true
}

output "vnet_id" {
  description = "The id of the virtual network. (containing 8 segments)."
  value       = azurerm_virtual_network.source_vnet.id
  sensitive = true
}