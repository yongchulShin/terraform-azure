terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.107.0"
    }
  }
}

provider "azurerm" {
  features {}
  alias           = "source" # alias 속성을 사용하면 resource 마다 provider를 지정해야함.
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}
  alias           = "common" # alias 속성을 사용하면 resource 마다 provider를 지정해야함.
  subscription_id = var.common_subscription_id
}

data "azurerm_resource_group" "dev" {
  provider = azurerm.source
  name     = var.resource_group_name
}

# 타겟 리소스 그룹을 데이터 소스로 참조
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
data "azurerm_resource_group" "common_rg" {
  provider = azurerm.common
  name     = var.common_resource_group_name
}

# 타겟 가상 네트워크를 데이터 소스로 참조
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network
data "azurerm_virtual_network" "common_vnet" {
  provider            = azurerm.common
  name                = "common-network-vnet"
  resource_group_name = data.azurerm_resource_group.common_rg.name
}

# data "azurerm_virtual_network" "source_vnet" {
#   provider            = azurerm.source
#   name                = var.vnet_name
#   resource_group_name = data.azurerm_resource_group.dev.name
# }

# 네트워크 피어링
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering
resource "azurerm_virtual_network_peering" "SourceToCommon" {
  provider                     = azurerm.source
  name                         = "peerSourceToCommon"
  resource_group_name          = data.azurerm_resource_group.dev.name
  virtual_network_name         = var.vnet_name # data.azurerm_virtual_network.source_vnet.name
  remote_virtual_network_id    = data.azurerm_virtual_network.common_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_virtual_network_peering" "CommonToSource" {
  provider                     = azurerm.common
  name                         = "peerCommonToSource"
  resource_group_name          = data.azurerm_resource_group.common_rg.name
  virtual_network_name         = data.azurerm_virtual_network.common_vnet.name
  remote_virtual_network_id    = var.vnet_id # data.azurerm_virtual_network.source_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}