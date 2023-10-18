/* resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
} */


/* provider "azurerm" {
  features {}
}

# Define the resource group names
variable "resource_group_names" {
  default = ["my-resource-group-1", "my-resource-group-2"]
}


# Create two resource groups
resource "azurerm_resource_group" "example" {
  count = length(var.resource_group_names)
  name     = var.resource_group_names[count.index]
  location = "East US"  # Replace with your desired Azure region
}

resource "azurerm_virtual_network_hub" "v-net" {
  count = length(var.resource_group_names)
  name = var.azurerm_virtual_network_hub[count.index]
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allow_virtual_network_access = true
  address_space = ["10.0.0.0/24"]
}

resource "azurerm_virtual_network_spoke" "v-net" {
  count = length(var.resource_group_names)
  name = var.azurerm_virtual_network_spoke[count.index]
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allow_virtual_network_access = true
  address_space = ["10.0.0.0/24"]
} */


# Define your Azure provider configuration
provider "azurerm" {
  features {}
}

# Create the first virtual network
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = "west US 2" # Change to your desired location
  resource_group_name = "my-resource-group"
}

# Create the second virtual network
resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  address_space       = ["10.1.0.0/16"]
  location            = "West US 2" # Change to your desired location
  resource_group_name = "my-resource-group"
}

# Create virtual network peering from vnet1 to vnet2
resource "azurerm_virtual_network_peering" "peer1_to_2" {
  name                      = "peer1_to_2"
  resource_group_name       = "my-resource-group"
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
}

# Create virtual network peering from vnet2 to vnet1
resource "azurerm_virtual_network_peering" "peer2_to_1" {
  name                      = "peer2_to_1"
  resource_group_name       = "my-resource-group"
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
}
