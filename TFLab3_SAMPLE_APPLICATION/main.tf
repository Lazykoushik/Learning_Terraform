module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
  tags     = var.tags
}

locals {
  nsg_ruleset = {
    "application_nsg" = csvdecode(file("/home/koushik/Desktop/terraform_test_folder/nsg_app.csv"))
    "database_nsg"    = csvdecode(file("/home/koushik/Desktop/terraform_test_folder/nsg_db.csv"))
  }
}

locals {
  subnets = { for s in csvdecode(file("/home/koushik/Desktop/terraform_test_folder/subnets.csv")) : s.name => s }
}

module "networking" {
  source                     = "./modules/Network"
  vnet_name                  = "vnet-${var.application_name}-${var.environment_name}"
  primary_location           = var.primary_location
  base_address_space         = var.base_address_space
  resource_group_name        = module.resource_group.resource_group_name
  subnet_definitions         = local.subnets
  security_group_definitions = local.nsg_ruleset
  tags                       = { Environment = "${var.tags["Environment"]}-${var.tags["Cost-Center"]}" }
}



resource "tls_private_key" "vm_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "azurerm_key_vault" "keyvault-dev" {
  name                = "TerraformLab101-keyvault"
  resource_group_name = "rg-TerraformLab101-keyvault-dev"
}
/*
resource "azurerm_key_vault_secret" "VM1_ssh_PrivateKey" {
  name         = "VM1-ssh-PrivateKey"
  value        = tls_private_key.vm_ssh_key.private_key_pem
  key_vault_id = data.azurerm_key_vault.keyvault-dev.id
}

resource "azurerm_key_vault_secret" "VM1_ssh_PublicKey" {
  name         = "VM1-ssh-PublicKey"
  value        = tls_private_key.vm_ssh_key.public_key_openssh
  key_vault_id = data.azurerm_key_vault.keyvault-dev.id
}


module "Compute" {
  source              = "./modules/Compute"
  for_each            = toset([for i in range(var.vm_count) : "VM${i + 1}"])
  vm_name             = "${each.key}-TF-${var.environment_name}"
  vm_nic_name         = "NIC-${each.key}-${var.environment_name}"
  primary_location    = var.primary_location
  resource_group_name = module.resource_group.resource_group_name
  vm_subnet_id        = module.networking.subnet_ids["App-subnet"]
  public_ssh_key      = tls_private_key.vm_ssh_key.public_key_openssh
  tags                = { Environment = "${var.tags["Environment"]}-${var.tags["Cost-Center"]}" }
}
*/


locals {
  users = { for k in csvdecode(file("/home/koushik/Desktop/terraform_test_folder/users.csv")) : k.user_principal_name => k }
}
module "Usermanagement" {
  source          = "./modules/Usermanagement"
  user_definition = local.users
}

