# see https://registry.terraform.io/modules/Azure/network/azurerm/latest
module "network" {
  source  = "Azure/network/azurerm"
  version = "3.5.0"

  resource_group_name = azurerm_resource_group.project.name
  address_space       = var.cidr
  subnet_prefixes     = local.private_subnets

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
