resource "azurerm_resource_group" "azresource_group_tf_module" {
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
}

resource "random_string" "random" {
  length  = 8
  upper   = false
  special = false
}


resource "azurerm_storage_account" "az_storage_account_tf_module" {
  name                     = "stterraform${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.azresource_group_tf_module.name
  location                 = azurerm_resource_group.azresource_group_tf_module.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Tier = var.tags
  }
}

resource "azurerm_storage_container" "az_storage_container_tf_module" {
  name                  = "blob-container-${random_string.random.result}"
  storage_account_name  = azurerm_storage_account.az_storage_account_tf_module.name
  container_access_type = "container"
}

