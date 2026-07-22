#output "application_name" { value = var.application_name }
#output "env_name" { value = var.env_name }
#output "local_env" { value = local.env_prefix}
#output "local_complete_string" {value = local.app_name}
#output "suffix" {  value = random_string.suffix.result }
#output "application_nature" {  value = var.application_nature}
#output "api_key" {  value     = "${var.api_key} ${"Onnu"}"sensitive = true}
#output "application_type" {value = var.application_type}
#output "Instance_ennikai" { value = var.Instance_ennikai}
#output "Fifth_region" { value = var.regions[6] }
#output "second_region" { value = var.regions[3] }
#output "last_region" { value = var.regions[5] }
#output "region_Set" { value = var.regions_Set }
#output "region_dictionary" { value = var.region_dictionary }
#output "region_RAM" { value = var.region_dictionary.ram }
#output "VM_Specs" {  value = var.VM_Specs}

output "Region_Configuration_Outputs" {
  value = module.regions_configuration.VM1.region_module_output
}
output "Region_Configuration_Outputs_VM2" {
  value = module.regions_configuration.VM2.region_module_output

}


output "rando_charlie_output" {
  value = module.random_string.charlie_random_string
}
