data "azurerm_mssql_server" "sqlsrv_block" {
  for_each = var.RG
  name                = "examplesqlserver"
  resource_group_name = each.value.rgname
}
