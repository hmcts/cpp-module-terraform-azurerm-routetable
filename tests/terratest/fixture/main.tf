provider "azurerm" {
  features {}
}

resource "random_id" "rg_name" {
  byte_length = 8
}
resource "azurerm_resource_group" "test" {
  name     = "test-${random_id.rg_name.hex}-rg"
  location = var.location
}
module "routetable" {
  source              = "../../../"
  resource_group_name = azurerm_resource_group.test.name
  location            = var.location
  route_prefixes      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  route_nexthop_types = ["VnetLocal", "VnetLocal", "VnetLocal"]
  route_names         = ["route1", "route2", "route3"]
  //next_hop_in_ip_address = "null"

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}
