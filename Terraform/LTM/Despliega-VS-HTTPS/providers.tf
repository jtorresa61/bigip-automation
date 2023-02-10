terraform {
  required_providers {
    bigip = {
      source = "F5Networks/bigip"
      version = ">= 1.16.0"
    }
  }
}
provider "bigip" {
  address  = var.bigip
  username = var.username
  password = var.password
}