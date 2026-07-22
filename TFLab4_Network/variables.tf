variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "environment_name" {
  description = "Name of the environment"
  type        = string
}

variable "primary_location" {
  description = "Name of the primary location"
  type        = string
}


variable "tags" {
  description = "Tag definition"
  type        = map(string)
}


variable "base_address_space" {
  description = " Address space for the  virtual network and its subnets"
  type        = string
}
