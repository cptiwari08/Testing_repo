resource "azurerm_public_ip" "lb_pip" {
  for_each = var.RG
  name                = each.value.lb_pip_name
  location            = each.value.location
  resource_group_name = each.value.rgname
  allocation_method   = "Static"
  sku                 = each.value.pip_sku
}

resource "azurerm_lb" "loadbalancer" {
  for_each = var.RG
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.rgname
  sku = each.value.lb_sku

  frontend_ip_configuration {
    name                 = each.value.frontend_pip_name
    public_ip_address_id = data.azurerm_public_ip.lb_pip[each.key].id
  }
}

# Create a backend pool for the Load Balancer and populate it with VM IPs
resource "azurerm_lb_backend_address_pool" "bkpool-address" {
  for_each = var.RG
  name                           = each.value.backend_pool_name
  loadbalancer_id                = azurerm_lb.loadbalancer[each.key].id
  }

resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
  for_each = var.RG
  name                    = each.value.lb_bkpool-addresses_name-01
  backend_address_pool_id = azurerm_lb_backend_address_pool.bkpool-address[each.key].id
  virtual_network_id      = data.azurerm_virtual_network.vnet_block[each.key].id
  ip_address              = data.azurerm_network_interface.nic_block[each.key].private_ip_address
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx02" {
  for_each = var.RG
  name                    = each.value.lb_bkpool-addresses_name-02
  backend_address_pool_id = azurerm_lb_backend_address_pool.bkpool-address[each.key].id
  virtual_network_id      = data.azurerm_virtual_network.vnet_block[each.key].id
  ip_address              = data.azurerm_network_interface.nic_block[each.key].private_ip_address
}
  resource "azurerm_lb_probe" "lbprobe" {
    for_each = var.RG
  loadbalancer_id = azurerm_lb.loadbalancer[each.key].id
  name            = "http-port"
  port            = 80
  
}
resource "azurerm_lb_rule" "example" {
  for_each = var.RG
  loadbalancer_id                = azurerm_lb.loadbalancer[each.key].id
  name                           = "NginxRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = each.value.frontend_pip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bkpool-address[each.key].id]
  probe_id                       = azurerm_lb_probe.lbprobe[each.key].id
}