variable "region" {
  description = "Region Name"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM resource"
  type        = string
}

variable "min_node_count" {
  description = "Minimum number of nodes in the cluster"
  type        = number
}

variable "max_node_count" {
  description = "Maximum number of nodes in the cluster"
  type        = number
}
