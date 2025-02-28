variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "myResourceGroup"
}

variable "location" {
  description = "The Azure region to deploy resources"
  default     = "East US"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  default     = "myVNet"
}

variable "subnet_name" {
  description = "The name of the subnet"
  default     = "mySubnet"
}

variable "sql_server_name" {
  description = "The name of the Azure SQL Server"
  default     = "mySqlServer"
}

variable "sql_db_name" {
  description = "The name of the Azure SQL Database"
  default     = "mySampleDatabase"
}

variable "admin_username" {
  description = "The administrator username for SQL Server"
  default     = "sqladmin"
}

variable "admin_password" {
  description = "The administrator password for SQL Server"
  default     = "P@ssw0rd1234"
}

variable "private_endpoint_name" {
  description = "The name of the private endpoint"
  default     = "myPrivateEndpoint"
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone"
  default     = "privatelink.database.windows.net"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "Azure Client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}
