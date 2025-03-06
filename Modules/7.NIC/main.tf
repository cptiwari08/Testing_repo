resource "azurerm_network_interface" "nic_block" {
  for_each            = var.RG
  name                = each.value.nicname
  resource_group_name = each.value.rgname
  location            = each.value.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_block[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
