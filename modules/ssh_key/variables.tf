variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
  # 값은 terraform.tfvars 파일에
}

variable "ssh_key_name" {
  description = "The name of the SSH key"
  type        = string
  default     = "salpha-azure"
}