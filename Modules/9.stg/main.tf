resource "azurerm_storage_account" "stg_block" {
    for_each = var.RG
  name                     = "examplestoraccount"
  resource_group_name      = each.value.rgname
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

}

data "azurerm_storage_account" "stg_block" {
  for_each            = var.RG
  name                = each.value.stgname
  resource_group_name = each.value.rgname
}

resource "azurerm_storage_container" "container_block" {
  for_each = var.RG

  name                  = each.value.containername
  storage_account_name  = azurerm_storage_account.stg_block[each.key].name
  container_access_type = "private"
}
