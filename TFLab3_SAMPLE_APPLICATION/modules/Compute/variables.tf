variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "vm_nic_name" {
  type        = string
  description = "name of the network interface card for the virtual machine"
}

variable "primary_location" {
  type        = string
  description = "Primary location for the resources"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "vm_subnet_id" {
  type        = string
  description = "ID of the subnet for the virtual machine"
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "public_ssh_key" {
  type        = string
  sensitive   = true
  description = "Public SSH key for the virtual machine"
}
