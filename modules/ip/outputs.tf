output "ip_address" {
  description = "The ip address"
  value       = azurerm_public_ip.example_pip.ip_address
}

output "public_ip_address_id" {
  description = "The public ip address id"
  value       = azurerm_public_ip.example_pip.id
}