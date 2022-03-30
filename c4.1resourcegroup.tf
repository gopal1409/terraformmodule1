resource "azurerm_resource_group" "myrg" {
  name     = local.rg_name
  location = "EAST Us"
  tags     = local.common_tags
}