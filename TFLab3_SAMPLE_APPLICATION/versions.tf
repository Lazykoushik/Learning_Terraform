# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.3"
    }
  }

  backend "azurerm" {}

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  #subscription_id = "a716beb2-b2df-4736-9ddb-64b3dbaf82d7"
}
