output "ssh_private_key" {
  description = "The private SSH key"
  value       = tls_private_key.example_ssh_key.private_key_pem
  sensitive   = true
}

output "vm_identity" {
  description = "The identity of virtual machine"
  value       = azurerm_linux_virtual_machine.example_vm.identity[0].principal_id
  sensitive   = true
}

output "vm_name" {
  description = "The name of virtual machine"
  value       = azurerm_linux_virtual_machine.example_vm.name
}