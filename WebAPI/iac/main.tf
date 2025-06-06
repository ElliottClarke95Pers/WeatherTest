provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "weather"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size = "Standard_B2ms"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
