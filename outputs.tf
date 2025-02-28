output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "sql_msserver_name" {
  description = "The name of the Azure SQL Server"
  value       = azurerm_mssql_server.sql_server.name
}

output "sql_database_name" {
  description = "The name of the Azure SQL Database"
  value       = azurerm_mssql_database.sql_db.name
}

output "private_endpoint_ip" {
  description = "The private IP address of the Private Endpoint"
  value       = azurerm_private_endpoint.private_endpoint.private_service_connection[0].private_ip_address
}
