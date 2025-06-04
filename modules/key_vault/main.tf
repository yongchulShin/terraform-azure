# data "azurerm_virtual_machine" "source_vm" {
#   provider            = azurerm.source
#   resource_group_name = var.resource_group_name
#   name                = var.vm_name
# }

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
resource "azurerm_key_vault" "example_kv" {
  name                = var.kv_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = var.tenant_id
    lifecycle {
    prevent_destroy = true
  }
}

