resource "azurerm_linux_virtual_machine" "vm_block" {
  for_each                        = var.RG
  name                            = each.value.vmname
  resource_group_name             = each.value.rgname
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = "false"

network_interface_ids = [
    data.azurerm_network_interface.nic_block[each.key].id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
