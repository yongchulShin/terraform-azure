output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.example_kv.vault_uri
}

output "key_vault_id" {
  description = "The id of the Key Vault"
  value       = azurerm_key_vault.example_kv.id
}