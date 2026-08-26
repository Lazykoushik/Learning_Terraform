

output "vm_private_ip" {
  value = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_public_ip" {
  value = azurerm_public_ip.VM_pip.ip_address
}
