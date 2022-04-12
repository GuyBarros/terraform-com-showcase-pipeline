////////////////////// Main //////////////////////////


// Primary

output "Vault_address" {
  value = data.tfe_outputs.demostack.values.Vault
  sensitive = true
}


output "Consul_address" {
  value = data.tfe_outputs.demostack.values.Consul
  sensitive = true
}



/*
output "tfc_notifications_ips" {
  value = data.tfe_ip_ranges.addresses.notifications
}
*/

output "output_message" {
  value = <<EOT

 your CI/CD pipeline configuration has finished, happy coding

EOT
  sensitive = false
}

