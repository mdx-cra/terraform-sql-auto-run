
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroupTA"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "myVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = "mysqlserverkbmdx123ta" # All lowercase, no hyphens at ends
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd1234"
}

resource "azurerm_mssql_database" "sql_db" {
  name                 = "mySampleDatabase"
  server_id            = azurerm_mssql_server.sql_server.id
  sku_name             = "S0"
  storage_account_type = "Local" # Corrected value

  threat_detection_policy {
    state                      = "Enabled"
    storage_endpoint           = azurerm_storage_account.example.primary_blob_endpoint
    storage_account_access_key = azurerm_storage_account.example.primary_access_key
  }
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "myPrivateEndpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "myConnection"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false # Set to true if manual approval is required
  }
}

resource "azurerm_private_dns_zone" "private_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "myDNSLink"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_a_record" "dns_a_record" {
  name                = azurerm_mssql_server.sql_server.name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.private_endpoint.private_service_connection[0].private_ip_address]
}

resource "azurerm_storage_account" "example" {
  name                     = "krishnamdxstrgta"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
