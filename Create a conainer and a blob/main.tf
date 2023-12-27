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

resource "azurerm_resource_group" "app_grp" {
name = "app-grp"
location = "east us"
}

# Create a Storage Account

resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformstorage678394"
  resource_group_name      = "app-grp"
  location                 = "east us"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# To Create a Container
resource "azurerm_storage_container" "data" {
  name                  = "container1"
  storage_account_name  = "terraformstorage678394"
  container_access_type = "private"
}

# This is used to upload a file onto the container

resource "azurerm_storage_blob" "sample" {
  name                   = "samplefile.txt"
  storage_account_name   = "terraformstorage678394"
  storage_container_name = "container1"
  type                   = "Block"
  source                 = "samplefile.txt"
  }