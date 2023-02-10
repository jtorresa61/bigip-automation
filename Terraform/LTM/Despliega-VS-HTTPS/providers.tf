terraform {
  required_providers {
    bigip = {
      source = "terraform-providers/bigip"
    }
  required_version = ">= 0.13"
  }
}
provider "bigip" {
  address  = var.bigip
  username = var.username
  password = var.password
}