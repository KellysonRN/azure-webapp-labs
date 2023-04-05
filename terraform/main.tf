terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "rg_labs" {
  name     = "rg-${var.proof_name}-${var.env}-${random_integer.ri.result}-${var.location}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_service_plan" "service_plan" {
  name                = "serviceplan-${var.proof_name}-${var.env}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_labs.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "api-${var.proof_name}-${var.env}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_labs.name
  service_plan_id     = azurerm_service_plan.service_plan.id
  https_only          = true

  app_settings = {
    "PING" = "PONG"
  }

  site_config {
    minimum_tls_version = "1.2"
    always_on           = false
    app_command_line    = "dotnet run DotNetProject.Api"

    application_stack {
      dotnet_version = "6.0"
    }

    cors {
      allowed_origins = ["*"]
    }

  }
}
