resource_group_name = "rg-terraform-azure-demo"
location            = "eastus"

vnet_hub_001            = "vnet-hub-eastus-001"
snet_default            = "snet-default"
as_hub_001_vnet         = ["10.2.0.0/16"]
as_hub_001_snet_default = ["10.2.0.0/24"]