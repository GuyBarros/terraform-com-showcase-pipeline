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
