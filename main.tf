module "ip" {
  source              = "./modules/ip"
  pip_name            = local.pip_name
  resource_group_name = var.resource_group_name
  subscription_id     = var.subscription_id
  location            = var.location
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  vnet_name           = local.vnet_name
  vnet_address_space  = var.vnet_address_space
  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "nsg_association" {
  source              = "./modules/network_association/nsg_association"
  subscription_id     = var.subscription_id
  nsg_name            = local.nsg_name
  resource_group_name = var.resource_group_name
  subnet_id           = module.network_interface.subnet_id
  location            = var.location
}

module "network_interface" {
  source                = "./modules/network_interface"
  subscription_id       = var.subscription_id
  nic_name              = local.nic_name
  ip_configuration_name = var.ip_configuration_name
  resource_group_name   = var.resource_group_name
  subnet_name           = local.subnet_name
  subnet_prefix         = var.subnet_prefix
  vnet_name             = module.virtual_network.vnet_name
  pip_name              = local.pip_name
  public_ip_address_id  = module.ip.public_ip_address_id
  location              = var.location
}

module "virtual_machine" {
  source              = "./modules/virtual_machine"
  vm_name             = local.vm_name
  vm_size             = var.vm_size
  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  nic_name            = local.nic_name
  nic_id              = module.network_interface.nic_id
  location            = var.location
  disk_size           = var.disk_size
  admin_username      = var.admin_username
  ssh_key_name        = var.ssh_key_name
}

module "mysql" {
  source                         = "./modules/mysql"
  mysql_private_dns_zone_name    = local.mysql_private_dns_zone_name
  mysql_name                     = local.mysql_name
  mysql_admin_password           = var.mysql_admin_password
  mysql_admin_username           = var.mysql_admin_username
  subscription_id                = var.subscription_id
  resource_group_name            = var.resource_group_name
  location                       = var.location
  mysql_flexible_server_sku_name = var.mysql_flexible_server_sku_name
}

module "network_peering" {
  source                     = "./modules/network_association/network_peering"
  common_resource_group_name = var.common_resource_group_name
  subscription_id            = var.subscription_id
  common_subscription_id     = var.common_subscription_id
  resource_group_name        = var.resource_group_name
  vnet_name                  = module.virtual_network.vnet_name
  vnet_id                    = module.virtual_network.vnet_id
}

# module "application_gateway" {
#   source                         = "./modules/network_association/application_gateway"
#   subscription_id                = var.subscription_id
#   common_resource_group_name     = var.common_resource_group_name
#   common_subscription_id         = var.common_subscription_id
#   common_application_gateway     = var.common_application_gateway
#   nic_name                       = local.nic_name
#   ip_configuration_name          = var.ip_configuration_name
#   nic_id                         = module.network_interface.nic_id
#   location                       = var.location

#   backend_address_pool           = var.backend_address_pool
#   backend_setting_port           = var.backend_setting_port
#   listener_name                  = var.listener_name
#   http_setting_name              = var.http_setting_name
#   frontend_ip_configuration_name = var.frontend_ip_configuration_name
#   request_routing_rule           = var.request_routing_rule
#   frontend_port_name             = var.frontend_port_name
#   backend_setting_protocol       = var.backend_setting_protocol
# }

module "key_vault" {
  source                 = "./modules/key_vault"
  subscription_id        = var.subscription_id
  resource_group_name    = var.resource_group_name
  kv_name                = local.kv_name
  tenant_id              = var.tenant_id
  common_subscription_id = var.common_subscription_id
  vm_name                = module.virtual_machine.vm_name
  vm_identity            = module.virtual_machine.vm_identity
  location               = var.location
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy
resource "azurerm_key_vault_access_policy" "vm" {
  provider     = azurerm.source
  key_vault_id = module.key_vault.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = module.virtual_machine.vm_identity # data.azurerm_virtual_machine.source_vm.identity[0].principal_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]

  key_permissions = [
    "Get",
    "List",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]
    lifecycle {
    prevent_destroy = true
  }
}

data "azurerm_client_config" "current" {
  provider = azurerm.source
}

resource "azurerm_key_vault_access_policy" "client" {
  provider = azurerm.source
  key_vault_id = module.key_vault.key_vault_id
  tenant_id = var.tenant_id
  object_id = module.virtual_machine.vm_identity # data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]

  key_permissions = [
    "Get",
    "List",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]
    lifecycle {
    prevent_destroy = true
  }
}


# # 가상 네트워크 생성
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
# resource "azurerm_virtual_network" "source_vnet" {
#   provider            = azurerm.source
#   name                = local.vnet_name
#   address_space       = [var.vnet_address_space]
#   location            = azurerm_resource_group.source_rg.location
#   resource_group_name = azurerm_resource_group.source_rg.name
# }

# # 서브넷 생성
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
# resource "azurerm_subnet" "subnet" {
#   provider             = azurerm.source
#   name                 = local.subnet_name
#   resource_group_name  = azurerm_resource_group.source_rg.name
#   virtual_network_name = azurerm_virtual_network.source_vnet.name
#   address_prefixes     = [var.subnet_prefix]
#   # delegation {
#   #   name = "mysql-delegation"
#   #   service_delegation {
#   #     name    = "Microsoft.DBforMySQL/flexibleServers"
#   #     actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#   #   }
#   # }
# }

# # 보안 그룹 생성
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# resource "azurerm_network_security_group" "example" {
#   provider            = azurerm.source
#   name                = local.nsg_name
#   location            = azurerm_resource_group.source_rg.location
#   resource_group_name = azurerm_resource_group.source_rg.name

#   security_rule {
#     name                       = "AllowAnyHTTPInbound"
#     priority                   = 310
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "AllowAnyHTTPSInbound"
#     priority                   = 320
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "443"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "AllowAnyCustom3000Inbound"
#     priority                   = 330
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "3000"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "AllowCidrBlockSSHInbound"
#     priority                   = 340
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   tags = {
#     environment = "Production"
#   }
# }

# # 서브넷에 네트워크 보안 그룹 연결
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association
# resource "azurerm_subnet_network_security_group_association" "example_subnet_nsg" {
#   provider                  = azurerm.source
#   subnet_id                 = azurerm_subnet.subnet.id
#   network_security_group_id = azurerm_network_security_group.example.id
# }

# # 타겟 리소스 그룹을 데이터 소스로 참조
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
# data "azurerm_resource_group" "common_rg" {
#   provider = azurerm.common
#   name     = var.common_resource_group_name
# }

# # 타겟 가상 네트워크를 데이터 소스로 참조
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network
# data "azurerm_virtual_network" "common_vnet" {
#   provider            = azurerm.common
#   name                = "common-network-vnet"
#   resource_group_name = data.azurerm_resource_group.common_rg.name
# }

# # 네트워크 피어링
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering
# resource "azurerm_virtual_network_peering" "SourceToCommon" {
#   provider                     = azurerm.source
#   name                         = "peerSourceToCommon"
#   resource_group_name          = azurerm_resource_group.source_rg.name
#   virtual_network_name         = azurerm_virtual_network.source_vnet.name
#   remote_virtual_network_id    = data.azurerm_virtual_network.common_vnet.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = true
# }

# resource "azurerm_virtual_network_peering" "CommonToSource" {
#   provider                     = azurerm.common
#   name                         = "peerCommonToSource"
#   resource_group_name          = data.azurerm_resource_group.common_rg.name
#   virtual_network_name         = data.azurerm_virtual_network.common_vnet.name
#   remote_virtual_network_id    = azurerm_virtual_network.source_vnet.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = true
# }

# # SSH 키 생성
# # https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
# resource "tls_private_key" "example_ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ssh_public_key
# resource "azurerm_ssh_public_key" "example_ssh_key" {
#   provider            = azurerm.source
#   name                = var.ssh_key_name
#   resource_group_name = azurerm_resource_group.source_rg.name
#   location            = azurerm_resource_group.source_rg.location
#   public_key          = tls_private_key.example_ssh_key.public_key_openssh
# }

# # 공용 IP 주소 생성
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
# resource "azurerm_public_ip" "example_pip" {
#   provider            = azurerm.source
#   name                = local.pip_name
#   location            = azurerm_resource_group.source_rg.location
#   resource_group_name = azurerm_resource_group.source_rg.name
#   allocation_method   = "Static"
# }

# # 네트워크 인터페이스 생성
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
# resource "azurerm_network_interface" "example_nic" {
#   provider            = azurerm.source
#   name                = local.nic_name
#   location            = azurerm_resource_group.source_rg.location
#   resource_group_name = azurerm_resource_group.source_rg.name

#   ip_configuration {
#     name                          = var.ip_configuration_name
#     subnet_id                     = azurerm_subnet.subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.example_pip.id
#   }
# }

# # Common Application Gateway의 리소스 ID
# data "azurerm_application_gateway" "common" {
#   name                = var.common_application_gateway
#   resource_group_name = var.common_resource_group_name
# }

# # 등록할 백엔드 풀에 속하는 VM의 IP 주소
# resource "azurerm_network_interface_backend_address_pool_association" "example" {
#   count                   = length(data.azurerm_application_gateway.common.backend_address_pool)
#   network_interface_id    = local.nic_name
#   ip_configuration_name   = var.ip_configuration_name
#   backend_address_pool_id = data.azurerm_application_gateway.common.backend_address_pool[count.index].id
# }


# # 가상 머신에서 SSH 접속을 허용하기 위해 NSG 규칙 추가
# resource "azurerm_network_security_rule" "allow_ssh" {
#   name                        = "Allow-SSH"
#   priority                    = 1001
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "22"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   network_security_group_name = azurerm_network_security_group.example_nsg.name
#   resource_group_name         = azurerm_resource_group.source_rg.name
# }

# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
# resource "azurerm_private_dns_zone" "example" {
#   provider            = azurerm.source
#   name                = local.mysql_private_dns_zone_name
#   resource_group_name = azurerm_resource_group.source_rg.name
# }

# # Azure Database for MySQL 유동 서버 생성
# # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server
# resource "azurerm_mysql_flexible_server" "example_mysql" {
#   provider               = azurerm.source
#   name                   = local.mysql_name
#   location               = azurerm_resource_group.source_rg.location
#   resource_group_name    = azurerm_resource_group.source_rg.name
#   administrator_login    = var.mysql_admin_username
#   administrator_password = var.mysql_admin_password
#   sku_name               = var.mysql_flexible_server_sku_name
#   # storage_mb = 5120
#   version                = "8.0.21"
#   # delegated_subnet_id = azurerm_subnet.subnet.id
#   private_dns_zone_id    = azurerm_private_dns_zone.example.id
# }
