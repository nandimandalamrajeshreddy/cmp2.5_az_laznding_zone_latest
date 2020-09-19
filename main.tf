#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Create a Linux VM
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = ">= 2.20"



  features {}
}


#
# - Create a Resource Group
#



resource "azurerm_resource_group" "rg" {
    name                  =   "${var.prefix}-rg"
    location              =   var.location
}


#
# - Create a Resource Group Level  restriction
#

resource "azurerm_management_lock" "policy" {
  name       = "${var.prefix}-policy"
  scope      = azurerm_resource_group.rg.id
  lock_level = "CanNotDelete"
}



#
# - Create a Virtual Network
#

resource "azurerm_virtual_network" "vnet" {
    name                  =   "${var.prefix}-vnet"
    resource_group_name   =   azurerm_resource_group.rg.name
    location              =   azurerm_resource_group.rg.location
    address_space         =   [var.vnet_address_range]
}

#
# - Create a Subnet inside the virtual network
#

resource "azurerm_subnet" "sn" {
    name                  =   "${var.prefix}-sn-subnet"
    resource_group_name   =   azurerm_resource_group.rg.name
    virtual_network_name  =   azurerm_virtual_network.vnet.name
    address_prefixes      =   [var.subnet_address_range]
}


#
# - Create a Availability Set
#

resource "azurerm_availability_set" "availability_set" {
   name                          = "${var.prefix}-availability_set"
   location                      = azurerm_resource_group.rg.location
   resource_group_name           = azurerm_resource_group.rg.name
   managed                       = var.managed
   platform_fault_domain_count   = var.platform_fault_domain_count

}


#
# - Create a Network Security Group
#

resource "azurerm_network_security_group" "nsg" {
    name                        =       "${var.prefix}-web-nsg"
    resource_group_name         =       azurerm_resource_group.rg.name
    location                    =       azurerm_resource_group.rg.location

    security_rule {
    name                        =       "Allow_SSH"
    priority                    =       1000
    direction                   =       "Inbound"
    access                      =       "Allow"
    protocol                    =       "Tcp"
    source_port_range           =       "*"
    destination_port_range      =       22
    source_address_prefix       =       "*" 
    destination_address_prefix  =       "*"
    
    }
}


#
# - Subnet-NSG Association
#

resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {
    subnet_id                    =       azurerm_subnet.sn.id
    network_security_group_id    =       azurerm_network_security_group.nsg.id
}


#
# - Create a Storage account with Network Rules
#

resource "azurerm_storage_account" "sa" {
    name                          =    var.storage_account_name
    resource_group_name           =    azurerm_resource_group.rg.name
    location                      =    azurerm_resource_group.rg.location
    account_tier                  =    var.account_tier
    account_replication_type      =    var.account_replication_type
}
