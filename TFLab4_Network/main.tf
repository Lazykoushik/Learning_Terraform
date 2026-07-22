resource "azurerm_resource_group" "azresource_group_tf_module" {
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
  tags     = var.tags
}


resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.application_name}-${var.environment_name}"
  location            = azurerm_resource_group.azresource_group_tf_module.location
  resource_group_name = azurerm_resource_group.azresource_group_tf_module.name
  address_space       = [var.base_address_space]
  tags                = { Environment = "${var.tags["Environment"]}-${var.tags["Project"]}" }
}



resource "azurerm_subnet" "application_subnet" {
  name                 = "APP-subnet"
  resource_group_name  = azurerm_resource_group.azresource_group_tf_module.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.base_address_space, 8, 3)]

}


resource "azurerm_subnet" "database_subnet" {
  name                 = "DB-subnet"
  resource_group_name  = azurerm_resource_group.azresource_group_tf_module.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.base_address_space, 8, 1)]

}


resource "azurerm_subnet" "Gateway_subnet" {
  name                 = "GW-subnet"
  resource_group_name  = azurerm_resource_group.azresource_group_tf_module.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.base_address_space, 12, 6)]



}

