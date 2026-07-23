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

resource "azurerm_network_security_group" "application_nsg" {
  name                = "app-nsg-${var.application_name}-${var.environment_name}"
  location            = azurerm_resource_group.azresource_group_tf_module.location
  resource_group_name = azurerm_resource_group.azresource_group_tf_module.name

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = {
    environment = "${var.tags["Environment"]}"
  }
}



locals {
  db_nsg_rules = csvdecode(file("/home/koushik/Desktop/nsg.csv"))
}


resource "azurerm_network_security_group" "database_nsg" {
  name                = "db-nsg-${var.application_name}-${var.environment_name}"
  location            = azurerm_resource_group.azresource_group_tf_module.location
  resource_group_name = azurerm_resource_group.azresource_group_tf_module.name


  dynamic "security_rule" {
    for_each = local.db_nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = {
    environment = "${var.tags["Environment"]}" 
#Test1
  }
}

