primary_location   = "eastus2"
base_address_space = "10.120.0.0/16"
#tags = {
#  "Environment" = "dev"
#  "Owner"       = "koushik"
#  "Project"     = "TerraformLab101"
#}
nsg_rules = [{
  name                       = "Allow-SSH"
  priority                   = 120
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  },
  {
    name                       = "Allow-HTTP"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },

  {
    name                       = "Allow-HTTPS"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

]
