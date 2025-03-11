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
  
  name                           = each.value.backend_pool_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  }

resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
  
  name                    = each.value.lb_bkpool-addresses_name-01
  backend_address_pool_id = azurerm_lb_backend_address_pool.bkpool-address.id
  virtual_network_id      = data.azurerm_virtual_network.vnet_block.id
  ip_address              = data.azurerm_network_interface.nic_block.private_ip_address
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx02" {
  
  name                    = each.value.lb_bkpool-addresses_name-02
  backend_address_pool_id = azurerm_lb_backend_address_pool.bkpool-address.id
  virtual_network_id      = data.azurerm_virtual_network.data-vnet.id
  ip_address              = data.azurerm_network_interface.nic_block.private_ip_address
}
  resource "azurerm_lb_probe" "nginxprobe" {
    
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "http-port"
  port            = 80
  
}
resource "azurerm_lb_rule" "example" {
  for_each = var.RG
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "NginxRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = each.value.frontend_pip_name
  
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bkpool-address.id]
  probe_id                       = azurerm_lb_probe.nginxprobe.id
}