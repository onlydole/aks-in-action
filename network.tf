# These resources replace the archived Azure/network/azurerm module, which
# only supports AzureRM 3.x. Names and address ranges match what it created.
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "vnet" {
  name                = "acctvnet"
  resource_group_name = azurerm_resource_group.project.name
  location            = azurerm_resource_group.project.location
  address_space       = [var.cidr]

  tags = {
    environment = "dev"
  }
}

# The old module only created one subnet, from the first prefix.
# see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.project.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.private_subnets[0]]
}

# see https://developer.hashicorp.com/terraform/language/moved
moved {
  from = module.network.azurerm_virtual_network.vnet
  to   = azurerm_virtual_network.vnet
}

moved {
  from = module.network.azurerm_subnet.subnet[0]
  to   = azurerm_subnet.subnet1
}

locals {
  private_subnets = [
    cidrsubnet(var.cidr, 8, 1),
    cidrsubnet(var.cidr, 8, 2),
    cidrsubnet(var.cidr, 8, 3)
  ]
}
