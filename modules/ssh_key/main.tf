# SSH 키 생성
# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
resource "tls_private_key" "example_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ssh_public_key
resource "azurerm_ssh_public_key" "example_ssh_key" {
  provider            = azurerm.source
  name                = var.ssh_key_name
  resource_group_name = data.azurerm_resource_group.dev.name
  location            = data.azurerm_resource_group.dev.location
  public_key          = tls_private_key.example_ssh_key.public_key_openssh
}