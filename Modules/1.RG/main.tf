resource "azurerm_resource_group" "rg_block" {
  for_each = var.RG
  name = each.value.rgname
  location = each.value.location
}