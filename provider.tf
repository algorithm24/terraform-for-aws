locals {
  access_key = ""
  secret_key = ""
}
provider "aws" {
  access_key = local.access_key
  secret_key = local.secret_key
  region     = "us-east-1"
}
