# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}


module "vnet_hub_001" {
  source        = "./modules/vnet"
  rg_name       = azurerm_resource_group.main.name
  location      = azurerm_resource_group.main.location
  vnet_name     = var.vnet_hub_001
  address_space = var.as_hub_001_vnet
}

module "snet_hub_001_default" {
  source        = "./modules/subnet"
  rg_name       = azurerm_resource_group.main.name
  location      = azurerm_resource_group.main.location
  name          = var.snet_default
  vnet_name     = module.vnet_hub_001.name
  address_space = var.as_hub_001_snet_default
  nsg           = true
}