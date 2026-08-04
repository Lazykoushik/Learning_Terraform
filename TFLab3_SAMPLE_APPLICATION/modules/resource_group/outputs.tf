output "resource_group_id" {
  value       = azurerm_resource_group.rg_main.id
  description = "ID of the created Resource Group"
}

output "resource_group_name" {
  value       = azurerm_resource_group.rg_main.name
  description = "Name of the created Resource Group"
}


output "resource_group_location" {
  value = azurerm_resource_group.rg_main.location
}
