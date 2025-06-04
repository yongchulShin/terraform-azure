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


variable "common_application_gateway" {
  description = "The common application gateway"
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

variable "nic_id" {
  description = "The id of network interface"
  type        = string
}

variable "http_setting_name" {
  description = "The name of backend setting"
  type        = string
}

variable "backend_setting_port" {
  description = "The port of backend setting"
  type        = string
}

variable "backend_setting_protocol" {
  description = "The protocol of backend setting"
  type        = string
}

variable "listener_name" {
  description = "The name of listener"
  type        = string
}

variable "frontend_ip_configuration_name" {
  description = "The name of frontend ip configuration"
  type        = string
}

variable "frontend_port_name" {
  description = "The name of frontend port"
  type        = string
}

variable "request_routing_rule" {
  description = "The name of request routing rule"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resources"
  type        = string
}

variable "backend_address_pool" {
  description = "The name of backend_address_pool"
  type        = string
}