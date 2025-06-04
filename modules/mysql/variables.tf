variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
}

variable "mysql_private_dns_zone_name" {
  description = "The name of mysql private dns zone"
  type        = string
}

variable "mysql_name" {
  description = "The name of mysql"
  type        = string
}

variable "mysql_admin_username" {
  description = "The admin username for the MySQL server"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "mysql_admin_password" {
  description = "The admin password for the MySQL server"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "mysql_flexible_server_sku_name" {
  description = "The name of mysql flexible server sku"
  type    = string
}

variable "location" {
  description = "The location of resource group"
  type        = string
}