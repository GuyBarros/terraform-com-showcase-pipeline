resource "vault_consul_secret_backend" "app" {
  provider = vault.app
  path        = "consul"
  description = "Manages the Consul backend"

  address = var.consul_address
  token   = var.consul_token
}

resource "vault_consul_secret_backend_role" "app" {
  provider = vault.app
  name    = "${var.application_name}-role"
  backend = vault_consul_secret_backend.app.path

  policies = [
    "${var.application_name}_policy","global-management",
  ]
}