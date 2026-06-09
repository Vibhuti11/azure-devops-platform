module "resource_group" {
  source = "../../mdules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source = "../../mdules/network"

  vnet_name           = var.vnet_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

module "aks_nsg" {
  source = "../../mdules/nsg"

  nsg_name            = "nsg-aks-dev"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.network.aks_subnet_id
}

module "db_nsg" {
  source = "../../mdules/nsg"

  nsg_name            = "nsg-db-dev"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.network.db_subnet_id
}

module "acr" {
  source = "../../mdules/acr"

  acr_name            = "acrvibhuti2026"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
}
module "aks" {
  source = "../../mdules/aks"

  aks_name            = "aks-dev-platform"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.network.aks_subnet_id
  acr_id              = module.acr.acr_id
}


