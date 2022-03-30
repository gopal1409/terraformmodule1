/*resource "azurerm_virtual_network" "myvnet" {
  name                = local.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  tags                = local.common_tags
}

resource "azurerm_subnet" "mysubnet" {
  name                 = local.snet_name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.0.0/24"]
}*/

module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "2.6.0"
  vnet_name = local.vnet_name
  resource_group_name = azurerm_resource_group.myrg.name 
  address_space = ["10.0.0.0/16"]
  subnet_prefixes = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  subnet_names = ["subnet1","subnet2","subnet3"]
  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage","Microsoft.Sql"]
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }
  tags = {
    environment = "dev"
    costcenter = "it"
  }
  # insert the 2 required variables here
}

resource "azurerm_public_ip" "mypublicip" {
  name                = local.pip_name
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"
  domain_name_label   = "app1-${var.environment}-${random_string.myrandom.id}"
  tags                = local.common_tags
}

resource "azurerm_network_interface" "myvmnic" {
  name                = local.nic_name
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublicip.id
  }
  tags = local.common_tags
}