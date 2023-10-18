/* resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
} */


provider "azurerm" {
  features {}
}

# Define the resource group names
variable "resource_group_names" {
  default = ["my-resource-group-1", "my-resource-group-2"]
}
variable "azurerm_virtual_network_hub" {
  default = ["hub-v-net-1"]
}
variable "azurerm_virtual_network_spoke" {
  default = ["spoke-v-net-1","spoke-v-net-1"]
}

# Create two resource groups
resource "azurerm_resource_group" "example" {
  count = length(var.resource_group_names)
  name     = var.resource_group_names[count.index]
  location = "East US"  # Replace with your desired Azure region
}

resource "azurerm_virtual_network_hub" "example" {
  count = length(var.resource_group_names)
  name = var.azurerm_virtual_network_hub[count.index]
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space = ["10.0.0.0/24"]
}

resource "azurerm_virtual_network_spoke" "example" {
  count = length(var.resource_group_names)
  name = var.azurerm_virtual_network_spoke[count.index]
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space = ["10.0.0.0/24"]
}