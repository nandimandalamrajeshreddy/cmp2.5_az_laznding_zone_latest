#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Linux VM - Variables
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

# Prefix and Tags

variable "prefix" {
    description =   "Prefix to append to all resource names(Eg: CMP or Morpheusproject)"
    type        =   string
    default     =   "rajeshdmt"
}

# Resource Group

variable "location" {
    description =   "Location of the resource group"
    type        =   string
    default     =   "West Europe"
}


# Vnet

variable "vnet_address_range" {
    description =   "IP Range of the virtual network"
    type        =   string
    default     =   "10.0.0.0/16"
}

variable "subnet_address_range" {
    description =   "IP Range of the virtual network"
    type        =   string
    default     =   "10.0.1.0/24"
}

# Availability Set

variable "managed" {
    description = "Managed disks provide better reliability for Availability Sets"
    type    =   string
    default =   true
}

variable "platform_fault_domain_count" {
    description = "The number of fault domains for managed availability sets varies by region"
    type    =   string
    default =   2
}

# Storage 

variable "storage_account_name" {
    description = "Variables for Storage account name(Storage account name should be unique(Eg:saopsdf2)"
    default     = "saghtd34"
}

variable "account_tier"  {
    description  =  "Variables for Storage accounts"
    type         =  string
    default      =  "Standard"
}


variable "account_replication_type"  {
    description  =  "Variables for Storage accounts"
    type         =  string
    default      =  "LRS"
}