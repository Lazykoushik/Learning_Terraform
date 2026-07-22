
resource "random_string" "random" {
  length  = 8
  upper   = false
  special = false
}


#resource "azurerm_resource_group" "az-backend-rg" {
#  name     = "rg-${var.application_name}-${var.environment_name}"
#  location = var.primary_location
#}


resource "azurerm_storage_account" "StorageAccount" {
  name                     = "stterraform${random_string.random.result}" # must be globally unique, lowercase, no dashes
  resource_group_name      = "rg-Backend_tfstate-test"
  location                 = var.primary_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Tier             = "${var.environment_name}"
    Application_name = "${var.application_name}"
  }
}


resource "azurerm_storage_container" "Blobcontainer" {
  name                  = "tfstate-files"
  storage_account_name  = azurerm_storage_account.StorageAccount.name
  container_access_type = "container"
}



