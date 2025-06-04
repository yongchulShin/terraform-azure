# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
# resource "azurerm_private_dns_zone" "example" {
#   provider            = azurerm.source
#   name                = var.mysql_private_dns_zone_name
#   resource_group_name = var.resource_group_name

#   lifecycle {
#     prevent_destroy = true
#     ignore_changes = [
#       # 실제 변경이 필요한 속성만 제외하고 추가
#       name,
#       resource_group_name,
#     ]
#   }
# }

# Azure Database for MySQL 유동 서버 생성
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server
resource "azurerm_mysql_flexible_server" "example_mysql" {
  provider               = azurerm.source
  name                   = var.mysql_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.mysql_admin_username
  administrator_password = var.mysql_admin_password
  sku_name               = var.mysql_flexible_server_sku_name
  version                = "8.0.21"
  zone                   = 3
  # delegated_subnet_id = azurerm_subnet.subnet.id
  # private_dns_zone_id    = azurerm_private_dns_zone.example.id

  lifecycle {
    prevent_destroy = true
  }
}
