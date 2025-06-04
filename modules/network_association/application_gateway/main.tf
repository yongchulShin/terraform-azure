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

# Common Application Gateway의 리소스 ID
data "azurerm_application_gateway" "common" {
  provider             = azurerm.common
  name                 = var.common_application_gateway
  resource_group_name  = var.common_resource_group_name
  location             = var.location

  backend_address_pool {
    name = var.backend_address_pool
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = var.backend_setting_port
    protocol              = var.backend_setting_protocol
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = ""
  }

  request_routing_rule {
    name               = var.request_routing_rule
    rule_type          = "PathBaseRouting"
    http_listener_name = var.listener_name
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "example" {
  provider                = azurerm.common
  count                   = length(data.azurerm_application_gateway.common.backend_address_pool)
  network_interface_id    = var.nic_id
  ip_configuration_name   = var.ip_configuration_name
  backend_address_pool_id = data.azurerm_application_gateway.common.backend_address_pool[count.index].id
}