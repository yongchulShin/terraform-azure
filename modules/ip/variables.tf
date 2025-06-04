variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
}

variable "pip_name" {
  description = "The name of public ip"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "location" {
  description = "The location of resource group"
  type        = string
}