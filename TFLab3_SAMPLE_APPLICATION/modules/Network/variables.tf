variable "vnet_name" {
  description = "Name of the Vnet"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "primary_location" {
  description = "Primary location for the resources"
  type        = string
}


variable "base_address_space" {
  description = "Base address space for the virtual network"
  type        = string
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}

variable "security_group_definitions" {
  description = "Map of NSG identifiers to their rule sets"
  type = map(list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  })))
}

variable "subnet_definitions" {
  description = "List of subnet definitions"
  type = map(object({
    name            = string
    cider_range     = string
    nsg_association = string
  }))
}
