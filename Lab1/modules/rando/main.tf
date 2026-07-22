
resource "random_string" "rando" {
  #for_each = var.region_dictionary_map_Count
  length      = var.charlie_input
  upper       = true
  special     = true
  min_special = 5
}

