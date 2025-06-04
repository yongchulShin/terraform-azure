variable "subscription_id" {
  description = "subscription id"
  type        = string
}

variable "common_subscription_id" {
  description = "common subscription id"
  type        = string
}

variable "common_resource_group_name" {
  description = "The name of common resource group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of resource group name"
  type        = string
}

variable "vnet_name" {
  description = "The name of virtual network"
  type        = string
}

variable "vnet_id" {
  description = "The id of virtual network"
  type        = string
}