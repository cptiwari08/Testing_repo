data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv_block" {
  for_each = var.RG
  name                       = each.value.kvname
  location                   = each.value.location
  resource_group_name        = each.value.rgname
  tenant_id                  = "25b7cafa-b5a5-472f-9c45-301d4d14e3cd"
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = "25b7cafa-b5a5-472f-9c45-301d4d14e3cd"
    object_id = "86255f80-8bd6-4862-8602-e25da3933cbc"

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "example" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.example.id
}