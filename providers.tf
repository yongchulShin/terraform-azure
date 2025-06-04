terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.107.0"
    }
  }
}

provider "azurerm" {
  features {}
  alias           = "source" # alias 속성을 사용하면 resource 마다 provider를 지정해야함.
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {}
  alias           = "common" # alias 속성을 사용하면 resource 마다 provider를 지정해야함.
  subscription_id = var.common_subscription_id
}
