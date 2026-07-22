variable "application_name" {
  description = "Application Name"
  type        = string
}
variable "env_name" {
  description = "Environment Name"
}

variable "application_nature" {
  description = "Application Nature"
  type        = string
}


variable "application_type" {
  description = "Application Type"
  type        = string

}

variable "Instance_ennikai" {
  description = "Instance ennikai"
  type        = number
}

variable "api_key" {
  sensitive = false

}


variable "regions" {
  description = "List of availabe Regions"
  type        = list(string)

}

variable "regions_Set" {
  description = "Set of availabe Regions"
  type        = set(string)
}

variable "region_dictionary" {
  description = "Dictionary of regions"
  type        = map(string)
}


variable "region_dictionary_map_Count" {
  description = "Dictionary of regions"
  type        = map(number)
}

variable "VM_Specs" {
  description = "Specifications of the VM"
  type = object({
    cpu            = number
    ram            = string
    storage        = string
    network        = string
    ip_range       = list(string)
    permenant      = bool
    Outbound_Ports = set(number)
  })

  validation {
    condition     = var.VM_Specs.permenant == true && var.VM_Specs.cpu < 32 && alltrue([for Port in var.VM_Specs.Outbound_Ports : Port >= 100 && Port <= 8080])
    error_message = "The condition should be false"
  }
}
