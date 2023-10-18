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

# Create two resource groups
resource "azurerm_resource_group" "example" {
  count = length(var.resource_group_names)
  name     = var.resource_group_names[count.index]
  location = "East US"  # Replace with your desired Azure region
}