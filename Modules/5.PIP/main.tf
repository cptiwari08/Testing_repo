resource "azurerm_public_ip" "pip_block" {
  for_each = var.RG
  name = each.value.pipname
  location = each.value.location
  resource_group_name = each.value.rgname
  allocation_method = each.value.allocation_method
}