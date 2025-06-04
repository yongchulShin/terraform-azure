variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
}

variable "vm_name" {
  description = "The name of virtual machine"
  type        = string  
}

variable "vm_size" {
  description = "The size of virtual machine"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the SSH key"
  type        = string
}

variable "disk_size" {
  description = "The size of the managed disk in GB"
  type        = number
}

variable "source_image_reference" {
    description = "The values of virtual machine source image references"
    type = object({
        publisher = string
        offer     = string
        sku       = string
        version   = string
    })
    default = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts-gen2"
        version   = "latest"
    }
}

variable "nic_name" {
  description = "The name of network interface"
  type        = string
}

variable "nic_id" {
  description = "The id of network interface"
  type        = string
}

variable "location" {
  description = "The location of resource group"
  type        = string
}