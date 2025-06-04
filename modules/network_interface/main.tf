# data "azurerm_virtual_network" "source_vnet" {
#   resource_group_name = var.resource_group_name
#   name                = var.vnet_name
# }

# data "azurerm_public_ip" "example_pip" {
#   name                = var.pip_name
#   resource_group_name = var.resource_group_name
# }

# 서브넷 생성
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name # data.azurerm_virtual_network.source_vnet.name
  address_prefixes     = [var.subnet_prefix]
  # delegation {
  #   name = "mysql-delegation"
  #   service_delegation {
  #     name    = "Microsoft.DBforMySQL/flexibleServers"
  #     actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
  #   }
  # }
}

# 네트워크 인터페이스 생성
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "example_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id# data.azurerm_public_ip.example_pip.id
  }
}