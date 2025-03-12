# Create an Azure SQL Server
resource "azurerm_mssql_server" "sqlsrv_block" {
  for_each                     = var.RG
  name                         = "examplesqlserver"
  resource_group_name          = each.value.rgname
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "StrongP@ssword123!"
}


# Create an Azure SQL Database
resource "azurerm_mssql_database" "sqldb_block" {
  name                        = "example-database"
  server_id                   = data.azurerm_mssql_server.sqlsrv_block[each.key].id
  collation                   = "SQL_Latin1_General_CP1_CI_AS" # Optional: Default collation
  max_size_gb                 = 5                              # Optional: Maximum size
  sku_name                    = "Basic"                        # Optional: Pricing tier
  auto_pause_delay_in_minutes = 60                             # Optional: For serverless database
  min_capacity                = 0.5                            # Optional: Minimum vCores for serverless
}


# # Optional: Configure a Firewall Rule to Allow Access
# resource "azurerm_sql_firewall_rule" "example" {
#   name                = "AllowAzureServices"
#   resource_group_name = each.value.rgname
#   server_name         = azurerm_sql_server.example.name
#   start_ip_address    = "0.0.0.0"
#   end_ip_address      = "0.0.0.0"
# }
