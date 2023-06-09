# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  client_id       = "eaab451a-f58c-4e1f-bbb5-a42e6b4c4937"
  client_secret   = "2~68Q~QbD1Plg3itKkzWdhdyp7-Rz_EtfbZB.ay9"
  subscription_id = "393e3de3-0900-4b72-8f1b-fb3b1d6b97f1"
  tenant_id       = "7349d3b2-951f-41be-877e-d8ccd9f3e73c"
}

##Resource Group
resource "azurerm_resource_group" "rg" {
name = "lingResourceGroupJenkins"
location = "france central"
}

##Avaibility Set
resource "azurerm_availability_set" "DemoAset" {
name = "tf-aset"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
}

##Virtual Network
resource "azurerm_virtual_network" "vnet" {
name = "tf-vNet"
address_space = ["10.0.0.0/16"]
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
}

##Subnet
resource "azurerm_subnet" "subnet" {
name = "Internal"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = ["10.0.2.0/24"]
}

##Network interface
resource "azurerm_network_interface" "example" {
name = "tf-vmwin-nic"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name

ip_configuration {
name = "internal"
subnet_id = azurerm_subnet.subnet.id
private_ip_address_allocation = "Dynamic"
}
}

##Azure Virtual Machine
resource "azurerm_windows_virtual_machine" "example" {
name = "tf-vmwin"
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
size = "Standard_F2"
admin_username = "adminuser"
admin_password = "P@$$w0rd1234!"
availability_set_id = azurerm_availability_set.DemoAset.id
network_interface_ids = [
azurerm_network_interface.example.id,
]

os_disk {
caching = "ReadWrite"
storage_account_type = "Standard_LRS"
}

source_image_reference {
publisher = "MicrosoftWindowsServer"
offer = "WindowsServer"
sku = "2022-Datacenter"
version = "latest"
}
}