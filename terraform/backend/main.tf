resource "azurerm_resource_group" "backend" {
  name     = "rg-terraform-backend"
  location = "East US"
}

resource "azurerm_storage_account" "backend" {
  name                     = "tfstatebackendstore01"
  resource_group_name      = azurerm_resource_group.backend.name
  location                 = azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version          = "TLS1_2"

  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "backend" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"
}