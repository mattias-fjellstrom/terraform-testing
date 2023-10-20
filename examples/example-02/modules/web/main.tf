terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name       = "rg-${var.name_prefix}-example-02"
  location   = var.location
  managed_by = "terraform"
}

resource "azurerm_storage_account" "stg" {
  name                     = "st${var.name_prefix}example02"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  access_tier              = "Hot"
  account_replication_type = "LRS"
  account_tier             = "Standard"

  public_network_access_enabled = false

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }
}

resource "azurerm_storage_blob" "index" {
  storage_account_name   = azurerm_storage_account.stg.name
  storage_container_name = "$web"
  type                   = "Block"
  name                   = "index.html"
  source_content         = var.index_file_content
  content_type           = "text/html"
}


