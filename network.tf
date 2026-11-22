# The Azure/network/azurerm module is archived and only supports AzureRM 3.x.
# This uses its Azure Verified Modules (AVM) replacement instead.
# see https://registry.terraform.io/modules/Azure/avm-res-network-virtualnetwork/azurerm/latest
module "network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.23.0"

  name          = "${var.project_name}-vnet"
  location      = azurerm_resource_group.project.location
  parent_id     = azurerm_resource_group.project.id
  address_space = [var.cidr]

  subnets = {
    for index, prefix in local.private_subnets : "subnet${index + 1}" => {
      name             = "subnet${index + 1}"
      address_prefixes = [prefix]
    }
  }

  # see https://www.terraform.io/docs/language/meta-arguments/depends_on.html
  depends_on = [
    azurerm_resource_group.project
  ]
}

locals {
  private_subnets = [
    cidrsubnet(var.cidr, 8, 1),
    cidrsubnet(var.cidr, 8, 2),
    cidrsubnet(var.cidr, 8, 3)
  ]
}
