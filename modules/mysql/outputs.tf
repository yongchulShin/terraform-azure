output "mysql_fqdn" {
  description = "The fully qualified domain name of the MySQL server"
  value       = azurerm_mysql_flexible_server.example_mysql.fqdn
}

output "replica_capacity" {
  description = "The maximum number of replicas that a primary MySQL Flexible Server can have."
  value       = azurerm_mysql_flexible_server.example_mysql.replica_capacity
}