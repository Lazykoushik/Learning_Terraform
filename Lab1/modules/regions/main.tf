resource "random_string" "VM_instantiation" {
  length      = 8
  upper       = false
  special     = false
  min_special = 5
}
