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


output "A_Welcome_Message" {
  value = <<EOF
export BOUNDARY_ADDR=${var.boundary_address}

boundary authenticate password -auth-method-id=${var.auth_method_id} -login-name=${var.username} -password=${var.password}
# Consul
boundary connect -target-id=${boundary_target.consul.id}
# Vault
boundary connect -target-id=${boundary_target.vault.id}
# Nomad
boundary connect -target-id=${boundary_target.nomad.id}
# SSH
boundary connect ssh -target-id=${boundary_target.backend_servers_ssh.id} -username ubuntu

EOF
}

