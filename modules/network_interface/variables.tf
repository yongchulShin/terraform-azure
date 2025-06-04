variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
}

variable "nic_name" {
  description = "The name of network interface"
  type        = string
}

variable "ip_configuration_name" {
  description = "The name of ip configuration"
  type        = string
}

variable "subnet_name" {
  description = "The name of subnet"
  type        = string
}

variable "subnet_prefix" {
  description = "subnet prefix"
  type        = string
}

variable "vnet_name" {
  description = "The name of virtual network"
  type        = string
}

variable "pip_name" {
  description = "The name of public ip"
  type        = string
}

variable "public_ip_address_id" {
  description = "The id of public ip address id"
  type        = string
}

variable "location" {
  description = "The location of resource group"
  type        = string
}