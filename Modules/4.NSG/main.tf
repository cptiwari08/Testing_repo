resource "azurerm_network_security_group" "nsg_block" {
  for_each = var.RG
  name = each.value.nsgname
  location = each.value.location
  resource_group_name = each.value.rgname
}