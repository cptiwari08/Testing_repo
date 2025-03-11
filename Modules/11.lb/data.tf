# Retrieve the IP address of the virtual machine
data "azurerm_virtual_network" "vnet_block" {
  name = each.value.vnetname
  resource_group_name = each.value.rgname
}


data "azurerm_network_interface" "nic_block" {
  name                = each.value.nicname
  resource_group_name = each.value.rgname
}

# data "azurerm_network_interface" "data-nic-02" {
#   name                = var.lb_map.data_nic_name-02
#   resource_group_name = var.lb_map.rg_name
# }