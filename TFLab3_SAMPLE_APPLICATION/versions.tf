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

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~>2.3.0"
    }

  }

  backend "azurerm" {}

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  #subscription_id = "a716beb2-b2df-4736-9ddb-64b3dbaf82d7"
}

provider "azuread" {
  tenant_id = "d920f09f-32af-49ff-8dcd-3536774c4ba6"
}

provider "azapi" {
  #subscription_id = "a716beb2-b2df-4736-9ddb-64b3dbaf82d7"
}
