provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}

terraform {
  cloud {
    organization = "starlight"
    workspaces {
      name = "terraform-for-aws"
    }
  }
}
locals {
  test = test
}