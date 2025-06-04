output "name" {
  description = "The name of the subnet. Changing this forces a new resource to be created."
  value       = azurerm_subnet.subnet.name
}

output "address_prefixes" {
  description = "The address prefixes for the subnet."
  value       = azurerm_subnet.subnet.address_prefixes
}

output "nic_id" {
  description = "The id of network interface."
  value       = azurerm_network_interface.example_nic.id
}

output "subnet_id" {
  description = "The id of subnet."
  value       = azurerm_subnet.subnet.id
}