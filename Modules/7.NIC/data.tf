data "azurerm_subnet" "subnet_block" {
  for_each = var.RG
  name = each.value.sbnetname
  virtual_network_name = each.value.vnetname
  resource_group_name = each.value.rgname

}