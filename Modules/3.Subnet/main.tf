resource "azurerm_subnet" "subnet_block" {
  for_each = var.RG
  name = each.value.sbnetname
  resource_group_name = each.value.rgname
  address_prefixes = each.value.address_prefixes
  virtual_network_name = each.value.vnetname
}