terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "tfstatebackendstore01"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}