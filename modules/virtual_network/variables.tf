variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
}

variable "vnet_name" {
  description = "The name of virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "virtual network address space"
  type = string
  default = "10.1.40.0/26"
}

variable "location" {
  description = "The location of resource group"
  type        = string
}