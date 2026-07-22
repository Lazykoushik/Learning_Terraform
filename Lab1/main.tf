/*

locals {
  app_name   = "${var.application_name}*******${var.env_name}"
  env_prefix = "Dev"
}

resource "random_string" "suffix" {
  length      = 20
  upper       = false
  special     = false
  min_special = 5
}

resource "random_string" "for_each_map_Objects" {

  #for_each = var.region_dictionary_map_Count
  count       = var.VM_Specs.cpu
  length      = 20
  upper       = false
  special     = false
  min_special = 5

}

*/

module "random_string" {

  source        = "./modules/rando"
  charlie_input = 5
  charlie_name  = "KOUSHIK"

}

locals {
  region_ListOfObjects = [
    {
      region         = "EASTUS"
      vm_name        = "VM1"
      min_node_count = 5
      max_node_count = 10
    },
    {
      region         = "WESTUS"
      vm_name        = "VM2"
      min_node_count = 5
      max_node_count = 10
    }
  ]
  region_ListOfObjects_Map = {
    "VM1" = {
      region         = "EASTUS"
      min_node_count = 5
      max_node_count = 10
    },
    "VM2" = {
      region         = "WESTUS"
      min_node_count = 5
      max_node_count = 10
    }
  }
}


module "regions_configuration" {
  source         = "./modules/regions"
  for_each       = local.region_ListOfObjects_Map
  region         = each.value.region
  vm_name        = each.key
  min_node_count = each.value.min_node_count
  max_node_count = each.value.max_node_count
}

