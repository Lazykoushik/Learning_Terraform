
resource "azurerm_virtual_network" "vnet_app1" {
  name                = var.vnet_name
  location            = var.primary_location
  resource_group_name = var.resource_group_name
  address_space       = [var.base_address_space]
  tags                = var.tags
}

resource "azurerm_subnet" "subnet_creation" {
  for_each             = var.subnet_definitions
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_app1.name
  address_prefixes     = [each.value.cider_range]
}

resource "azurerm_network_security_group" "nsg_rule_creation" {
  for_each            = var.security_group_definitions
  name                = "nsg-${var.vnet_name}-${each.key}"
  location            = var.primary_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  dynamic "security_rule" {
    for_each = each.value
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
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {

  for_each                  = { for k, v in var.subnet_definitions : k => v if contains(keys(var.security_group_definitions), v.nsg_association) }
  subnet_id                 = azurerm_subnet.subnet_creation[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg_rule_creation[each.value.nsg_association].id

}

