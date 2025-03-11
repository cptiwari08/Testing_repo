# Create an Azure SQL Server
resource "azurerm_sql_server" "example" {
  for_each                     = var.RG
  name                         = "examplesqlserver"
  resource_group_name          = each.value.rgname
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "StrongP@ssword123!"
}

# Create an Azure SQL Database
resource "azurerm_sql_database" "example" {
  name                = "exampledatabase"
  resource_group_name = each.value.rgname
  location            = each.value.location
  server_name         = azurerm_sql_server.example.name
  sku_name            = "Basic"
}

# Optional: Configure a Firewall Rule to Allow Access
resource "azurerm_sql_firewall_rule" "example" {
  name                = "AllowAzureServices"
  resource_group_name = each.value.rgname
  server_name         = azurerm_sql_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
