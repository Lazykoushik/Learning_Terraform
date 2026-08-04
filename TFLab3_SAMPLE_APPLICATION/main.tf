module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
  tags     = var.tags
}

module "networking" {
  source              = "./modules/Network"
  vnet_name           = "vnet-${var.application_name}-${var.environment_name}"
  primary_location    = var.primary_location
  base_address_space  = var.base_address_space
  resource_group_name = module.resource_group.resource_group_name
  tags                = { Environment = "${var.tags["Environment"]}-${var.tags["Cost-Center"]}" }
}
