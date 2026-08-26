data "azurerm_subscription" "primary" {}
data "azuread_client_config" "current" {}

resource "azuread_user" "Terraform_Users" {
  for_each            = var.user_definition
  user_principal_name = each.key
  display_name        = each.value.display_name
  mail_nickname       = each.value.mail_nickname
  password            = each.value.password
  city                = each.value.city
  company_name        = each.value.company_name
  mobile_phone        = each.value.mobile_phone
}

resource "azuread_group" "Terraform_user_group" {
  display_name     = "TF-User-Operator-Group"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

  members = [
    for k, v in var.user_definition : azuread_user.Terraform_Users[k].object_id
  ]
}

resource "azurerm_role_assignment" "Terraform_user_group_role_assignment" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.Terraform_user_group.object_id
}
