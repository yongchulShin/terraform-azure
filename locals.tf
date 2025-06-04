locals {
  common_name                 = "${var.subscription_name}-${var.resource_group_name}"
  mysql_name                  = "${local.common_name}-db"
  pip_name                    = "${local.common_name}-ip"
  vnet_name                   = "${local.common_name}-vnet"
  subnet_name                 = "${local.common_name}-subnet"
  nic_name                    = "${local.common_name}-nic"
  vm_name                     = "${local.common_name}-vm"
  kv_name                     = "${local.common_name}-kv" # "name" may only contain alphanumeric characters and dashes and must be between 3-24 chars 에러 때문에 키볼트는 네이밍 짧게 해야함
  mysql_private_dns_zone_name = "${local.common_name}.mysql.database.azure.com"
  nsg_name                    = "${local.common_name}-nsg"
}