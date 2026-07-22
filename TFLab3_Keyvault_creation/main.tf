resource "azurerm_resource_group" "keyvault_resource_group" {
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
}

# This data block helps in abstracting the hardcoded values in the azurerm_key_vault block.
# Namely the subscription id, tenant ID or the principal ID. 
# It takes the current subscription and the current logged in user and fetches the details of the same.

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "lab_keyvault" {
  name                          = var.application_name
  location                      = azurerm_resource_group.keyvault_resource_group.location
  resource_group_name           = azurerm_resource_group.keyvault_resource_group.name
  enabled_for_disk_encryption   = true
  enabled_for_deployment        = true
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  public_network_access_enabled = true
  enable_rbac_authorization     = true
  tags = {
    environment_name = var.tags["Environment"]
    owner            = var.tags["Owner"]
    project_name     = var.tags["Project"]
  }
  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List"
    ]

    secret_permissions = [
      "Get", "List"
    ]

    storage_permissions = [
      "Get", "List"
    ]
  }
}


# Assiging RBAC to the key vault for the current user - 
# principal_id  --> who --> data.azurerm__client_config.current.object_id --> 
# This references to the current logged in user(kpkoushik)in the azure portal.
# Scope --> Which resource --> the resource - This should be as narrow as possible, in the doc, it has the scope set as the current subscription.
# Role_definition_name - what access -->  to be given to the user for which scope


resource "azurerm_role_assignment" "keyvault_RBAC" {
  scope                = azurerm_key_vault.lab_keyvault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}


data "azurerm_log_analytics_workspace" "observability_workspace_def" {
  name                = "LogAnalyticsWorkspace-Observability-test"
  resource_group_name = "rg-observability-test"
}


resource "azurerm_monitor_diagnostic_setting" "obervability_keyvault_diagnostic_setting" {
  name                       = "DiagnosticSetting-${var.application_name}-${var.environment_name}"
  target_resource_id         = azurerm_key_vault.lab_keyvault.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.observability_workspace_def.id

  enabled_log {
    category = "AuditEvent"
  }
  enabled_log {
    category = "AzurePolicyEvaluationDetails"
  }

  metric {
    category = "AllMetrics"
  }
}
