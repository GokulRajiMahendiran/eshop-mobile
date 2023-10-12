resource "azurerm_resource_group" "eshop_resource_group" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_service_plan" "eshop_service_plan" {
  name                = "${var.appname}-serviceplan"
  resource_group_name = azurerm_resource_group.eshop_resource_group.name
  location            = azurerm_resource_group.eshop_resource_group.location
  os_type             = "Windows"
  sku_name            = "F1"
}

resource "azurerm_windows_web_app" "eshop_web_app" {
  name                = var.appname
  resource_group_name = azurerm_resource_group.eshop_resource_group.name
  location            = azurerm_resource_group.eshop_resource_group.location
  service_plan_id     = azurerm_service_plan.eshop_service_plan.id

  site_config {
    always_on = false
    application_stack {
      dotnet_version = "v5.0"
    }

    # Define Default Application
    virtual_application {
      virtual_path  = "/"
      physical_path = "site\\wwwroot"
      preload       = true
    }

    # Define Additional Virtual Applications and Directories
    virtual_application {
      virtual_path  = "/catalogapi"
      physical_path = "site\\wwwroot\\catalogapi"
      preload       = true
    }

    virtual_application {
      virtual_path  = "/basketapi"
      physical_path = "site\\wwwroot\\basketapi"
      preload       = false
    }
  }
    app_settings = {
      "ASPNETCORE_ENVIRONMENT" = "Development"
      #"WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"
      #"WEBSITE_RUN_FROM_PACKAGE"        = "1"
  }

}
