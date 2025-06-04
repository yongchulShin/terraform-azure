variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "nsg_name" {
  description = "The name network security group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of resource group name"
  type        = string
}

variable "subnet_id" {
  description = "The id of subnet"
  type        = string
}

variable "location" {
  description = "The location of resource group"
  type        = string
}