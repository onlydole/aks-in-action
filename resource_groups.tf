resource "azurerm_resource_group" "project" {
  name     = var.project_name
  location = var.region
}
