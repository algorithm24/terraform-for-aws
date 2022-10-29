locals {
  access_key = "AKIA24Z7YKW7IZ3BD5PK"
  secret_key = "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"
}
provider "aws" {
  access_key = local.access_key
  secret_key = local.secret_key
  region     = "us-east-1"
}