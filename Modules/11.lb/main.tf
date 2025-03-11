# Create Load Balancer
resource "azurerm_lb" "example" {
  name                = "example-lb"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

# Create Backend Address Pool
resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.example.id
  name            = "example-backend-pool"
}

# Create Health Probe
resource "azurerm_lb_probe" "example" {
  name                = "example-probe"
  resource_group_name = azurerm_resource_group.example.name
  loadbalancer_id     = azurerm_lb.example.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

# Create Load Balancer Rule
resource "azurerm_lb_rule" "example" {
  name                          = "example-lb-rule"
  resource_group_name           = azurerm_resource_group.example.name
  loadbalancer_id               = azurerm_lb.example.id
  protocol                      = "Tcp"
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  frontend_port                 = 80
  backend_port                  = 80
  backend_address_pool_id       = azurerm_lb_backend_address_pool.example.id
  probe_id                      = azurerm_lb_probe.example.id
  enable_floating_ip            = false
  idle_timeout_in_minutes       = 4
}