# see https://registry.terraform.io/modules/Azure/aks/azurerm
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "4.13.0"

  kubernetes_version   = var.cluster_version
  orchestrator_version = var.cluster_version
  resource_group_name  = azurerm_resource_group.project.name
  prefix               = var.project_name
  enable_auto_scaling  = true
  agents_count         = null
  agents_min_count     = 1
  agents_max_count     = 10
  vnet_subnet_id       = module.network.vnet_subnets[0]
  os_disk_size_gb      = 100

  # see https://www.terraform.io/docs/language/meta-arguments/depends_on.html
  depends_on = [
    module.network
  ]
}
