# After importing the secrets storing into Locals
output "db-creds" {
  sensitive = true
  value = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}