# data "azurerm_network_interface" "example_nic" {
#   provider            = azurerm.source
#   resource_group_name = var.resource_group_name
#   name                = var.nic_name
# }

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
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = tls_private_key.example_ssh_key.public_key_openssh
}

# 가상 머신 생성
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "example_vm" {
  provider            = azurerm.source
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size

  network_interface_ids = [
    var.nic_id# data.azurerm_network_interface.example_nic.id,
  ]

  admin_username = "infra"

  admin_ssh_key {
    username   = "infra"
    public_key = tls_private_key.example_ssh_key.public_key_openssh
  }

  os_disk {
    caching                   = "ReadWrite"
    storage_account_type      = "StandardSSD_LRS"
    disk_size_gb              = var.disk_size
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  identity {
    type = "SystemAssigned"
  }
}