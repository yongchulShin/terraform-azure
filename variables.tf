### common
variable "common_subscription_id" {
  description = "The subscription id of common"
  type        = string
  # 값은 terraform.tfvars 파일에  
}

variable "common_resource_group_name" {
  description = "The name of the common resource group"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "common_application_gateway" {
  description = " The name of common application gateway"
  type        = string
}
###


# # 리소스 그룹 location
variable "location" {
  description = "The Azure region to deploy the resources"
  type        = string
}

# # virtual network
variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = string
}

variable "subnet_prefix" {
  description = "The address prefix for the subnet"
  type        = string
}

variable "ip_configuration_name" {
  description = "The name of ip configuration"
  type        = string
}

# # virtual machine
variable "vm_size" {
  description = "The size of the virtual machine"
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

# # mysql
variable "mysql_flexible_server_sku_name" {
  description = "The name of mysql flexible server sku"
  type    = string
  # sku_name should start with SKU tier B (Burstable), GP (General Purpose), MO (Memory Optimized) like B_Standard_B1s.
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

# # 구독
variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "tenant_id" {
  description = "The tenant ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "resource_group_name" {
  description = "The name of resource group"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "subscription_name" {
  description = "The name of subscription"
  type        = string
}

# variable "backend_address_pool" {
  
# }

# variable "backend_setting_port" {
  
# }

# variable "listener_name" {
  
# }

# variable "http_setting_name" {
  
# }

# variable "frontend_ip_configuration_name" {
  
# }

# variable "request_routing_rule" {
  
# }

# variable "frontend_port_name" {
  
# }

# variable "backend_setting_protocol" {
  
# }