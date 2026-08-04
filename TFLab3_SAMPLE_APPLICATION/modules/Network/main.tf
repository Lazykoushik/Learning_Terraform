
resource "azurerm_virtual_network" "vnet_app1" {
  name                = var.vnet_name
  location            = var.primary_location
  resource_group_name = var.resource_group_name
  address_space       = [var.base_address_space]
  tags                = var.tags
}


resource "azurerm_subnet" "application_subnet" {
  name                 = "APP-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_app1.name
  address_prefixes     = [cidrsubnet(var.base_address_space, 8, 3)]

}

resource "azurerm_subnet" "database_subnet" {
  name                 = "DB-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_app1.name
  address_prefixes     = [cidrsubnet(var.base_address_space, 8, 1)]

}

resource "azurerm_subnet" "Gateway_subnet" {
  name                 = "GW-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_app1.name
  address_prefixes     = [cidrsubnet(var.base_address_space, 12, 6)]
}

