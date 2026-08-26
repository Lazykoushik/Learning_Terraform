

resource "azurerm_public_ip" "VM_pip" {
  name                = "${var.vm_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.primary_location
  allocation_method   = "Static"

  tags = var.tags
}


resource "azurerm_network_interface" "vm_nic" {
  name                = var.vm_nic_name
  location            = var.primary_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.VM_pip.id
  }
}


resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.primary_location
  size                            = "Standard_D2als_v6"
  admin_username                  = var.admin_username
  tags                            = var.tags
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
