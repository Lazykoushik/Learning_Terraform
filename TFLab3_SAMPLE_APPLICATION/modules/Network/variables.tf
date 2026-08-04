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

