output "vnet_app1_id" {
  value       = azurerm_virtual_network.vnet_app1.id
  description = "ID of the created Virtual network for the Application 1"
}

output "vnet_app1_name" {
  value       = azurerm_virtual_network.vnet_app1.name
  description = "Name of the created Virtual network for the Application 1"
}

output "application_subnet_id" {
  value       = azurerm_subnet.application_subnet.id
  description = "ID of the created Application subnet"
}

output "application_subnet_name" {
  value       = azurerm_subnet.application_subnet.name
  description = "Name of the created Application subnet"
}


output "database_subnet_id" {
  value       = azurerm_subnet.database_subnet.id
  description = "ID of the created Database subnet"
}

output "database_subnet_name" {
  value       = azurerm_subnet.database_subnet.name
  description = "Name of the created Database subnet"
}

output "Gateway_subnet_id" {
  value       = azurerm_subnet.Gateway_subnet.id
  description = "ID of the created Gateway subnet"
}

output "Gateway_subnet_name" {
  value       = azurerm_subnet.Gateway_subnet.name
  description = "Name of the created Gateway subnet"
}
