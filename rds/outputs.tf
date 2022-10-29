output "password" {
  sensitive = true
  value = var.password
}
output "username" {
  value = var.username
}
output "endpoint" {
  value = aws_db_instance.mariadb.address
}