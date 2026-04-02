module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source = "./modules/network"

  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_prefixes     = var.subnet_address_prefixes
  location            = var.location
  resource_group_name = module.resource_group.name
  public_ip_name      = var.public_ip_name
  nic_name            = var.nic_name
}

data "azurerm_network_interface" "this" {
  name                = var.nic_name
  resource_group_name = module.resource_group.name

  depends_on = [module.network]
}

data "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  resource_group_name = module.resource_group.name

  depends_on = [module.network]
}

resource "azurerm_network_security_group" "this" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = module.resource_group.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = data.azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = var.vm_name
  resource_group_name = module.resource_group.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    data.azurerm_network_interface.this.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  computer_name                   = var.vm_name
  disable_password_authentication = true
}