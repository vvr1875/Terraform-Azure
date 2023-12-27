# we first specify the terraform provider
# Terraform will use the provider to ensure that we can work with Microsoft Azure

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
}

# Here we need to mention the Azure AD application object credentials to allow us to work with 
# Our Azure Account

provider "azurerm" {
  subscription_id = "23aa216e-620a-4f5e-b9b8-95b2541f2269"
  client_id       = "a2f186a4-6e65-49e3-9010-74ec13e19c3a"
  client_secret   = "Rub8Q~1nsKlDGn0fzpGnwmkLpSCfJuRafjsEwb6Y"
  tenant_id       = "6c69c303-abbf-420c-9bbd-8e617617b965"
  features {}
}

# The resource block defines the type of resouce we want to work with
# The name and location are arguments for the resource block

resource "azurerm_resource_group" "example" {
name = "app-grp"
location = "east us"
}

resource "azurerm_network_security_group" "example" {
  name                = "network-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Testing"
  }
}