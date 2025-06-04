variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "kv_name" {
  description = "The name of key vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
}

variable "tenant_id" {
  description = "tenant id"
  type        = string
}

variable "common_subscription_id" {
  description = "The id of common subscription"
  type        = string
}

variable "vm_name" {
  description = "The name of virtual machine"
  type        = string
}

variable "vm_identity" {
  description = "The principal ID of the VM identity"
  type        = string
}

variable "location" {
  description = "The location of resource group"
  type        = string
}