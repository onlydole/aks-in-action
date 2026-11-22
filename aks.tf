# see https://registry.terraform.io/modules/Azure/aks/azurerm
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "11.7.0"

  kubernetes_version   = var.cluster_version
  orchestrator_version = var.cluster_version
  resource_group_name  = azurerm_resource_group.project.name
  location             = azurerm_resource_group.project.location
  prefix               = var.project_name
  auto_scaling_enabled = true
  agents_count         = null
  agents_min_count     = 1
  agents_max_count     = 10
  os_disk_size_gb      = 100

  vnet_subnet = {
    id = azurerm_subnet.subnet1.id
  }

  # see https://www.terraform.io/docs/language/meta-arguments/depends_on.html
  depends_on = [
    azurerm_subnet.subnet1
  ]
}
