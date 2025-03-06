data "azurerm_network_interface" "nic_block" {
    for_each = var.RG
  name                = each.value.nicname
  resource_group_name = each.value.rgname
}